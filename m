Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A022C3FC73C
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Aug 2021 14:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhHaM12 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Aug 2021 08:27:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56097 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229625AbhHaM11 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Aug 2021 08:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630412792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tK3C44gbpJOAF7Lq8U9wVbpEND9tIhFpgRCKgTH9408=;
        b=hynzU/9NriSW3kPzpemtNYFRxuO6Ji6r8tN06hyiNsKT1+9c6npnQfxeiiOzr3RkWqp4+c
        9S18pFKmRh9WW4CuybAuR2SnR9WjP4tS1oAvzhomBQGfeFDzJnnhFMhzU5VIAww7omZ9M+
        Oa7Pxf8kxre/QERfXiQTqdbJeEFO/7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-XsOHGkMEPB6tqRvr1Sfv9A-1; Tue, 31 Aug 2021 08:26:30 -0400
X-MC-Unique: XsOHGkMEPB6tqRvr1Sfv9A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0238287D54D;
        Tue, 31 Aug 2021 12:26:30 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EA4B60CA0;
        Tue, 31 Aug 2021 12:26:29 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     schumaker.anna@gmail.com
Cc:     steved@redhat.com, linux-nfs@vger.kernel.org,
        Anna.Schumaker@Netapp.com
Subject: Re: [PATCH v3 0/9] Add a tool for using the new sysfs files
Date:   Tue, 31 Aug 2021 08:26:28 -0400
Message-ID: <B3E32B3D-1363-4AC6-900E-96D0E11973D0@redhat.com>
In-Reply-To: <20210830155653.1386161-1-Anna.Schumaker@Netapp.com>
References: <20210830155653.1386161-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 30 Aug 2021, at 11:56, schumaker.anna@gmail.com wrote:

> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>
> okay, or would it be better to name it "nfs" with "sysfs" as a
> subcommand? Going with just "nfs" as the command name would allow us to
> add other non-sysfs tools as subcommands in the future (such as `nfs stat`
> to call `nfsstat`, or for new commands that would otherwise be prefixed
> with "nfs")
>
> Thoughts?

I'm in favor of having a top-level nfs command tree for tools and
administrators, and even dropping the intermediate "sysfs" bit for these
subcommands.  I'd like to use `nfs xprt` and `nfs rpc-client`..etc.  I think
that the intermediate 'sysfs' is unnecessary.

If I can ever get around to completing it, I have some work for displaying
mount to xprt relationships and forcibly unmounting for unavailable servers
where I would like to use `nfs shutdown` or some variation.

Ben

