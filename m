Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4107D4A51EF
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jan 2022 22:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiAaV6K convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 31 Jan 2022 16:58:10 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:45648 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiAaV56 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jan 2022 16:57:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 45B4C613AFB8;
        Mon, 31 Jan 2022 22:57:50 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id o4lbWBph2q_X; Mon, 31 Jan 2022 22:57:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C6F40613AFB5;
        Mon, 31 Jan 2022 22:57:49 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id u-Dkzr5wQ8LC; Mon, 31 Jan 2022 22:57:49 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7E092613AFBF;
        Mon, 31 Jan 2022 22:57:49 +0100 (CET)
Date:   Mon, 31 Jan 2022 22:57:49 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     bfields <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        chris chilvers <chris.chilvers@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        Daire Byrne <daire@dneg.com>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>,
        david <david@sigma-star.at>, goliath <goliath@sigma-star.at>,
        trond myklebust <trond.myklebust@hammerspace.com>,
        anna schumaker <anna.schumaker@netapp.com>
Message-ID: <53054937.5849.1643666269238.JavaMail.zimbra@nod.at>
In-Reply-To: <20220131203742.GE30119@fieldses.org>
References: <20220131104316.10357-1-richard@nod.at> <20220131170125.GB30119@fieldses.org> <8290532.5517.1643649341941.JavaMail.zimbra@nod.at> <20220131203742.GE30119@fieldses.org>
Subject: Re: [RFC PATCH] mountd: export: Deal with NFS filesystems
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF96 (Linux)/8.8.12_GA_3809)
Thread-Topic: mountd: export: Deal with NFS filesystems
Thread-Index: 4FErjB2oqupkQfBZPJjydT926vM59g==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "bfields" <bfields@fieldses.org>
>> Unless I badly misunderstood the code it comes from fs/nfs/client.c's
>> nfs_create_server() where the NFS client fetches NFS_ATTR_FATTR via getattr().
>> So it should be unique:
>> https://datatracker.ietf.org/doc/html/rfc7530#section-5.8.1.9
> 
> Unique within one server, but not across different servers.
> 
> Depending on how your servers assign fsids, collisions might be quite
> likely.  Results of a collision would be pretty bad.

Hmm. So this means when you have a setup where the same file system is exported
via multiple servers (the load balancing use case), getattr on the same file can
report a different fsid at any time?
This renders the fsid attribute close to useless :-(

Anyway, this is not a show stopper just makes more clear that we should
take the FSID_NUM mapping path.
Please stay tuned, I'll send ASAP another patch.

Thanks,
//richard
