Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFBA471E1B
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Dec 2021 22:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhLLVvQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Sun, 12 Dec 2021 16:51:16 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:35854 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhLLVvP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Dec 2021 16:51:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5588262DA5E9;
        Sun, 12 Dec 2021 22:51:14 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LEN3gTgviSWZ; Sun, 12 Dec 2021 22:51:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id ECA3462DA5F0;
        Sun, 12 Dec 2021 22:51:13 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id z-WlFeTfJ2bk; Sun, 12 Dec 2021 22:51:13 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id C1BD862DA5E9;
        Sun, 12 Dec 2021 22:51:13 +0100 (CET)
Date:   Sun, 12 Dec 2021 22:51:13 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        anna schumaker <anna.schumaker@netapp.com>,
        david <david@sigma-star.at>
Message-ID: <720365903.160502.1639345873669.JavaMail.zimbra@nod.at>
In-Reply-To: <1812588409.160456.1639344774221.JavaMail.zimbra@nod.at>
References: <20211212210044.16238-1-richard@nod.at> <dd3aec8fed9bab9b3e62fc2093803688b7b71682.camel@hammerspace.com> <1812588409.160456.1639344774221.JavaMail.zimbra@nod.at>
Subject: Re: [RFC PATCH] NFS: Save 4 bytes when re-exporting
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF94 (Linux)/8.8.12_GA_3809)
Thread-Topic: Save 4 bytes when re-exporting
Thread-Index: AQHX75ta92YY4WU8k06yTBIDlSm7OawvXNEA1wwF3itcInypJA==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "richard" <richard@nod.at>
> ----- Ursprüngliche Mail -----
>> Von: "Trond Myklebust" <trondmy@hammerspace.com>
>> On Sun, 2021-12-12 at 22:00 +0100, Richard Weinberger wrote:
>>> When re-exporting, the whole struct nfs_fh is embedded in the new
>>> fhandle.
>>> But we need only nfs_fh->data[], nfs_fh->size is not needed.
>>> So skip fs_fh->size and save a full word (4 bytes).
>>> The downside is the extra memcpy() in nfs_fh_to_dentry().
>>> 
>>> Signed-off-by: Richard Weinberger <richard@nod.at>
>>> ---
>>> While investigating into improving NFS re-export I noticed that
>>> we can already save 4 bytes of overhead.
>>> I don't think we need to embedd the full struct nfs_fh and
>>> can skip ->size.
>>> 
>> 
>> NACK. This will break existing running clients. Any code to change the
>> filehandle format must be accompanied with code to detect and service
>> filehandles that are presented in the old format.
> 
> One possible way to distinguish between old and new formats
> is looking at the length of the data.
> 2 * XDR_UNIT = new format (without ->size).
> 3 * XDR_UNIT = old format.

Never mind. This won't work.

Thanks,
//richard
