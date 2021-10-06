Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E049C4240C8
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Oct 2021 17:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239148AbhJFPHg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Oct 2021 11:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239017AbhJFPHg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Oct 2021 11:07:36 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDB8C061746
        for <linux-nfs@vger.kernel.org>; Wed,  6 Oct 2021 08:05:44 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 46215703F; Wed,  6 Oct 2021 11:05:43 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 46215703F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1633532743;
        bh=d0aFDTfjKMGG3M3J43kokfnoSiVOru/b0ToCXahKw2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kAFov+9N8b2YzMBRXHoT0jlbPkqn3bCGFlSr8frQj+gdtwINkf6DnB1aMu6WfFv6n
         DwwlzAJzcGegqkE3K+YCLBTIHwoLLU39/hQ/UbYVr3u3OFyubZoR9eWrYKrrbh9TX2
         S4O9hzluuH6VJwH1LJGm9YnqrriK321oeUCsY+60=
Date:   Wed, 6 Oct 2021 11:05:43 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Dai Ngo <dai.ngo@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/2] st_courtesy.py: fix bug in COUR2 and add more tests
 for Courteous Server
Message-ID: <20211006150543.GC15343@fieldses.org>
References: <20211005234123.41053-1-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005234123.41053-1-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 05, 2021 at 07:41:21PM -0400, Dai Ngo wrote:
> This patch series fixes a bug in COUR2 test and also adds more tests
> for Courteous Server.
> 
> V2: Create bug fix as separate patch
>     Replace new_client and create_session with new_client_session.

Thanks, applying.

--b.
