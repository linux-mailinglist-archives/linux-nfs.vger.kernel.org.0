Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E73447C8D9
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Dec 2021 22:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbhLUVjy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 21 Dec 2021 16:39:54 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:45054 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhLUVjy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Dec 2021 16:39:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D9861614E2CD;
        Tue, 21 Dec 2021 22:39:52 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5oqHySuFOEVF; Tue, 21 Dec 2021 22:39:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3ABA062DA5F6;
        Tue, 21 Dec 2021 22:39:52 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UgH1ClS4nMGk; Tue, 21 Dec 2021 22:39:52 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 14F0A62DA5F1;
        Tue, 21 Dec 2021 22:39:52 +0100 (CET)
Date:   Tue, 21 Dec 2021 22:39:52 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Daire Byrne <daire@dneg.com>
Cc:     bfields <bfields@fieldses.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        luis turcitu <luis.turcitu@appsbroker.com>,
        chris chilvers <chris.chilvers@appsbroker.com>,
        david young <david.young@appsbroker.com>,
        david <david@sigma-star.at>,
        david oberhollenzer <david.oberhollenzer@sigma-star.at>
Message-ID: <312937657.191134.1640122792008.JavaMail.zimbra@nod.at>
In-Reply-To: <CAPt2mGM5jJNu_O=pjvU4UEYZ7L9pcunGedVmFP1h+J4QoMLPUg@mail.gmail.com>
References: <1576494286.153679.1639083948872.JavaMail.zimbra@nod.at> <20211209214139.GA23483@fieldses.org> <763412597.153709.1639087404752.JavaMail.zimbra@nod.at> <CAPt2mGM5jJNu_O=pjvU4UEYZ7L9pcunGedVmFP1h+J4QoMLPUg@mail.gmail.com>
Subject: Re: Improving NFS re-export
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF95 (Linux)/8.8.12_GA_3809)
Thread-Topic: Improving NFS re-export
Thread-Index: 36+NMuXi8gg0MYUQDELRQzsIwf/C2g==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Daire,

----- Ursprüngliche Mail -----
> Von: "Daire Byrne" <daire@dneg.com>
> Either way, I'm interested to see what you come up with. Always happy
> to test new variations on re-exporting.

David and I will share patches soon. We're quite happy with the kernel side,
but our rpc.mountd changes are still hacky.
We have a prove of concept fix for cross mounts and some crazy ideas how to
reduce the fhandle overhead when re-exporting.

Thanks,
//richard
