Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D4122F2DB
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jul 2020 16:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgG0Om5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Jul 2020 10:42:57 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57204 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgG0Om5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Jul 2020 10:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595860976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vVNRQxR9K9QbThb5tZf4JyIZx0WN214aia+dUA5Rs+U=;
        b=D5ILc8efILOPYYZaZZo3jeOd8I6Sn5MFIY+2Ox0B4PzY5ZoLUcPxCOvZRXTkwjEx20ZO0D
        b1MQNj0m6OELPIz3YGiZD9fYGPGeSZp6xkCW6jdXSXOXHp+QJkcAUiXM9Pq2OMnvrWFC4p
        kEP+O42iNWv0bYvBIEaQyQprXherEms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-4DVfOpfgN7KmL5MXZQp_gA-1; Mon, 27 Jul 2020 10:42:54 -0400
X-MC-Unique: 4DVfOpfgN7KmL5MXZQp_gA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7C5110BF;
        Mon, 27 Jul 2020 14:42:53 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-147.phx2.redhat.com [10.3.113.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B1266931E;
        Mon, 27 Jul 2020 14:42:53 +0000 (UTC)
Subject: Re: [PATCH 0/4] nfs-utils patches
To:     Doug Nazar <nazard@nazar.ca>, linux-nfs@vger.kernel.org
References: <20200722055354.28132-1-nazard@nazar.ca>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <86408474-69f7-f4b0-6608-98e409d6809e@RedHat.com>
Date:   Mon, 27 Jul 2020 10:42:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200722055354.28132-1-nazard@nazar.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7/22/20 1:53 AM, Doug Nazar wrote:
> A few more as I progress through all the utils. There isn't any
> dependency on the previous patches.
> 
> Although idmapd client support is depreciated, the kernel still falls
> back to using it if the upcall fails.
> 
> Wasn't originally going to send the last patch upstream, but figured
> might as well, and let you decide if it's wanted. Basically allows you
> to load the plugins from a development source tree for testing instead
> of requiring them to be installed in their final location.
> 
> Thanks,
> Doug
> 
> 
> Doug Nazar (4):
>   exportfs: Fix a few valgrind warnings
>   idmapd: Add graceful exit and resource cleanup
>   idmapd: Fix client mode support
>   nfsidmap: Allow overriding location of method libraries
Series committed... (tag: nfs-utils-2-5-2-rc3)

steved.
> 
>  support/nfs/exports.c          |   1 +
>  support/nfsidmap/libnfsidmap.c |  40 +++++--
>  utils/exportfs/exportfs.c      |   7 +-
>  utils/idmapd/idmapd.c          | 211 +++++++++++++++++++++++----------
>  4 files changed, 183 insertions(+), 76 deletions(-)
> 

