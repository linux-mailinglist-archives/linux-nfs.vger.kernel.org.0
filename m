Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B04643549A
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Oct 2021 22:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhJTUbZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Oct 2021 16:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhJTUbW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Oct 2021 16:31:22 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6548C06161C
        for <linux-nfs@vger.kernel.org>; Wed, 20 Oct 2021 13:29:07 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 0E8346CC9; Wed, 20 Oct 2021 16:29:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 0E8346CC9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1634761747;
        bh=tRu0EacVe2rJgGtykUTpMj+abm+3+uPVRoZ4reVprH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wAO4M2LoOi7boSjfRpxVq1PwHPbWJ+9TGZPHTANHg27uOAMF7fXV5+I8ZmBRZvJY/
         kzgiAyQjW6axvF3pRKiiA4zGgdz7bqrsdlxViQuHpEfAAtj8eIGXKEGTP6wTfzEagO
         doYDQLvTDgU5X8vq/f/xqgPMl5dGnp8AHObWERWY=
Date:   Wed, 20 Oct 2021 16:29:07 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Steve Dickson <steved@redhat.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: server-to-server copy by default
Message-ID: <20211020202907.GF597@fieldses.org>
References: <20211020155421.GC597@fieldses.org>
 <18E32DF5-3F1D-4C23-8C2F-A7963103CF8C@oracle.com>
 <CAN-5tyEL4L2GH=-MDGS4qNTcCLRPFCQzfDQjFAVbG7wMKvHxOg@mail.gmail.com>
 <8b1eb564-974d-00b6-397a-d92f301df7d8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b1eb564-974d-00b6-397a-d92f301df7d8@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 20, 2021 at 12:03:46PM -0700, dai.ngo@oracle.com wrote:
> 
> On 10/20/21 9:33 AM, Olga Kornievskaia wrote:
> >On Wed, Oct 20, 2021 at 12:00 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >>>2. Security question: with server-to-server copy enabled, you can send
> >>>the server a COPY call with any random address, and the server will
> >>>mount that address, open a file, and read from it.  Is that safe?
> 
> The client already has write access to the share on the destination
> server, it can write any data to the destination file.

Agreed.  Please look back at what I said; I'm not thinking about attacks
on the source server, I'm thinking about attacks on the destination (the
one that receives the COPY).

--b.
