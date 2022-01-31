Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1806E4A4CEC
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jan 2022 18:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350147AbiAaRP5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Mon, 31 Jan 2022 12:15:57 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:55332 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380916AbiAaRPo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jan 2022 12:15:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id AD833614E2EF;
        Mon, 31 Jan 2022 18:15:42 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id XrHhFDB2UMM4; Mon, 31 Jan 2022 18:15:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 399A4614E2E7;
        Mon, 31 Jan 2022 18:15:42 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SpKRC8uaALOC; Mon, 31 Jan 2022 18:15:42 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0E30562DA60B;
        Mon, 31 Jan 2022 18:15:42 +0100 (CET)
Date:   Mon, 31 Jan 2022 18:15:41 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     bfields <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        chris chilvers <chris.chilvers@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        Daire Byrne <daire@dneg.com>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>,
        david <david@sigma-star.at>, goliath@sigma-star.at,
        trond myklebust <trond.myklebust@hammerspace.com>,
        anna schumaker <anna.schumaker@netapp.com>
Message-ID: <8290532.5517.1643649341941.JavaMail.zimbra@nod.at>
In-Reply-To: <20220131170125.GB30119@fieldses.org>
References: <20220131104316.10357-1-richard@nod.at> <20220131170125.GB30119@fieldses.org>
Subject: Re: [RFC PATCH] mountd: export: Deal with NFS filesystems
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF96 (Linux)/8.8.12_GA_3809)
Thread-Topic: mountd: export: Deal with NFS filesystems
Thread-Index: eGwBPcjwbjFcFsSRyWvmeclhKZZ6PQ==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "bfields" <bfields@fieldses.org>
>> Using /proc/fs/nfsfs/volumes it is possible to find the NFS fsid
>> from the backend and use it as seed for mountd's UUID mechanism.
> 
> Sorry, I haven't checked--what is that number, really?  It's probably
> not the fsid returned from the server, as that wouldn't be guaranteed
> unique across multiple servers.  But that means it's probably generated
> in a way that doesn't guarantee it's stable across reboots.  And we need
> filehandles to work across reboots.

Unless I badly misunderstood the code it comes from fs/nfs/client.c's
nfs_create_server() where the NFS client fetches NFS_ATTR_FATTR via getattr().
So it should be unique:
https://datatracker.ietf.org/doc/html/rfc7530#section-5.8.1.9

Thanks,
//richard
