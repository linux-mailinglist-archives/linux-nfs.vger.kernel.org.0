Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6E18471E23
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Dec 2021 22:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhLLV5n convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Sun, 12 Dec 2021 16:57:43 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:35970 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhLLV5n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Dec 2021 16:57:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3666E62DA5E9;
        Sun, 12 Dec 2021 22:57:41 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id C98Zu0q6EXFN; Sun, 12 Dec 2021 22:57:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 61B0362DA5F0;
        Sun, 12 Dec 2021 22:57:40 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id K6Z7PkXH7Fdd; Sun, 12 Dec 2021 22:57:40 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 404F962DA5E9;
        Sun, 12 Dec 2021 22:57:40 +0100 (CET)
Date:   Sun, 12 Dec 2021 22:57:40 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        anna schumaker <anna.schumaker@netapp.com>,
        david <david@sigma-star.at>
Message-ID: <1388843712.160520.1639346260184.JavaMail.zimbra@nod.at>
In-Reply-To: <7a8d59679ed2ab948b8b694eb1df94e3a90fcc8a.camel@hammerspace.com>
References: <20211212210044.16238-1-richard@nod.at> <dd3aec8fed9bab9b3e62fc2093803688b7b71682.camel@hammerspace.com> <1812588409.160456.1639344774221.JavaMail.zimbra@nod.at> <7a8d59679ed2ab948b8b694eb1df94e3a90fcc8a.camel@hammerspace.com>
Subject: Re: [RFC PATCH] NFS: Save 4 bytes when re-exporting
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF94 (Linux)/8.8.12_GA_3809)
Thread-Topic: Save 4 bytes when re-exporting
Thread-Index: AQHX75ta92YY4WU8k06yTBIDlSm7OawvXNEA1wwF3iuo9AOGgGEBWxOo
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Trond Myklebust" <trondmy@hammerspace.com>
>> What do you think?
>> 
> 
> You don't a priori know the length of the underlying filehandle or its
> structure. All you know is that you have n bytes of data, and it is
> possible that the first 2 bytes represent the size 'n-2'. However it is
> also possible that those 2 bytes are something else that just happens
> to match the value 'n-2'.

Yes. ;-\
Our mails have crossed, after hitting send I realized my fault.

Thanks,
//richard
