Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265692A43D4
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Nov 2020 12:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgKCLNw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Nov 2020 06:13:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725988AbgKCLNv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Nov 2020 06:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604402030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9rIVPf+IwL+zTzjuBNh03e0uGauhtY/sr1K6K6wnFcU=;
        b=Z4BMhCG7oFJYnaGOeY3YzLacZSODEVQTeLTruKdrhB/K1Zenxyrg7AOAiZ6Dpayi/284t4
        3QIqRL3bt7sR6a7hQyPmnBed8k7C3GwOlO4LQ+ltWqDbRNuL/SXWaDIQTGbesi111NRCVH
        7I3ydbk7bVOuP09VpFCdvrxsw6RnwDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-HKrt-STDPLSurUF7nyql-w-1; Tue, 03 Nov 2020 06:13:46 -0500
X-MC-Unique: HKrt-STDPLSurUF7nyql-w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9486357083;
        Tue,  3 Nov 2020 11:13:45 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AB9373672;
        Tue,  3 Nov 2020 11:13:45 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] NFS: Remove unnecessary inode locking in
 nfs_llseek_dir()
Date:   Tue, 03 Nov 2020 06:13:44 -0500
Message-ID: <303B32DE-EE6D-445C-98B8-EB2446CE74E5@redhat.com>
In-Reply-To: <20201030215730.85147-1-trondmy@kernel.org>
References: <20201030215730.85147-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 30 Oct 2020, at 17:57, trondmy@kernel.org wrote:

> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>
> Remove the contentious inode lock, and instead provide thread safety
> using the file->f_lock spinlock.
>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben

