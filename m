Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E935E478C08
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 14:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbhLQNLS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 08:11:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:56677 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234054AbhLQNLS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 08:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639746677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jNOaUvWea5kATXBHygu3umLKedY5WoVPmiTsNULIomc=;
        b=LdjG7xGOT2Kk1dyJ2nOy1VSjeiFlKEAkTQOMmprppCxLiQtRmNgL7IqD9fPm/1vqQ+jrdz
        Zd21tWvYhYLQjQ5aAsQ5NAYlFg3HFubLkZXJlNGrzWyB9DlH51MfOxBdE4RXn6xt4k1egU
        BGdU/TeDNsaNxJZSJeOZOmpQN3wC8HU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-mBW6hOCIMnWqASeITQ6bQw-1; Fri, 17 Dec 2021 08:11:16 -0500
X-MC-Unique: mBW6hOCIMnWqASeITQ6bQw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C856801962;
        Fri, 17 Dec 2021 13:11:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6DF7101F6D4;
        Fri, 17 Dec 2021 13:11:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CALF+zO=zDrRzPkpgjRQNYbxQ8j3qNVJjo9Ub=tCqFtT32sr-KQ@mail.gmail.com>
References: <CALF+zO=zDrRzPkpgjRQNYbxQ8j3qNVJjo9Ub=tCqFtT32sr-KQ@mail.gmail.com> <20211217113507.76f852f2@canb.auug.org.au>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     dhowells@redhat.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        David Wysochanski <dwysocha@redhat.com>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the nfs-anna tree with the fscache tree
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1957082.1639746671.1@warthog.procyon.org.uk>
Date:   Fri, 17 Dec 2021 13:11:11 +0000
Message-ID: <1957083.1639746671@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

David Wysochanski <dwysocha@redhat.com> wrote:

> Anna, feel free to drop these from your tree to avoid the conflicts
> with the rest of your tree and dhowells fscache-rewrite patchset.

Would it help to take some bits through my tree?  (Or, at least, alter my NFS
patches)

David

