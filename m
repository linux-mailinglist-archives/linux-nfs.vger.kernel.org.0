Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB5123BB59
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Aug 2020 15:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgHDNqq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Aug 2020 09:46:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbgHDNqq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 4 Aug 2020 09:46:46 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 856AC2075D;
        Tue,  4 Aug 2020 13:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596548806;
        bh=XKnskYodvqAU8IeYcr7b/Q4x54TUcMl5mCwg3k2tzmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bfCqYAAy6qdjYWSv0vEYyrk6iNYP6H9qPQMObK5pC45/xDz69H7PmqIyVigbFCvTX
         1pgzPpKXmYsVzi4+szUqwK+ckKpQfEtCRvj5wm0+6L1zEDw8LLfrc4zZUKI/fwOcMT
         c74Vuqmkzvnjuk8gcwpcc4QKuzz1D6H5veBQwSSE=
Date:   Tue, 4 Aug 2020 16:46:42 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Timo Rothenpieler <timo@rothenpieler.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: NFS over RDMA issues on Linux 5.4
Message-ID: <20200804134642.GC4432@unreal>
References: <8a1087d3-9add-dfe1-da0c-edab74fcca51@rothenpieler.org>
 <CE6C02CE-3EEB-4834-B499-376BC6020A17@oracle.com>
 <20200804093635.GA4432@unreal>
 <92a5a932-b843-eed3-555e-7557ccc1f308@rothenpieler.org>
 <20200804122557.GB4432@unreal>
 <DAF6EFDA-5863-4887-B495-0BE3CA714209@oracle.com>
 <d41ac40e-8974-0a44-2b9f-bede74619935@rothenpieler.org>
 <F6BDB1B6-6315-47C9-A589-F4A57E25B2C5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F6BDB1B6-6315-47C9-A589-F4A57E25B2C5@oracle.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 04, 2020 at 09:12:55AM -0400, Chuck Lever wrote:
>
>
> > On Aug 4, 2020, at 9:08 AM, Timo Rothenpieler <timo@rothenpieler.org> wrote:
> >
> > On 04.08.2020 14:49, Chuck Lever wrote:
> >> Timo, I tend to think this is not a configuration issue.
> >> Do you know of a known working kernel?
> >
> > This is a brand new system, it's never been running with any kernel older than 5.4, and downgrading it to 4.19 or something else while in operation is unfortunately not easily possible. For a client it would definitely not be out of the question, but the main nfs server I cannot easily downgrade.
> >
> > Also keep in mind that the dmesg spam happens on both server and client simultaneously.
>
> Let's start with the client only, since restarting it seems to clear the problem.

It is client because according to the server CQE errors, it is Remote_Invalid_Request_Error
with "9.7.5.2.2 NAK CODES" from IBTA.

Thanks
