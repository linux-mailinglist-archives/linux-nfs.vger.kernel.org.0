Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D406223D53
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jul 2020 15:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgGQNyQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jul 2020 09:54:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26648 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726090AbgGQNyQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jul 2020 09:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594994056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bjFcpOUpRKawU2/RNUckL6N3Qmz0pABGT4OZrSSlCS8=;
        b=WlgSXkirQ33AsctdsJRW15lOv1IzQ8xLdS8bnGQK9DVCr7ldn2oOqeVwRLaVDT66BuZOCL
        PwJHHMf44E/48vQjH2Iv6NkpRRmCogBuZ1vltoo9KAbd7nd2FI3LCpnXMGLPOJQa+mVxqp
        DSHin3GZ0NKr5M8JcjjFPHpmIJDLc3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-kJv-pYbzPJuaAd314ZX8Cw-1; Fri, 17 Jul 2020 09:54:14 -0400
X-MC-Unique: kJv-pYbzPJuaAd314ZX8Cw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A65D9107ACCA
        for <linux-nfs@vger.kernel.org>; Fri, 17 Jul 2020 13:54:13 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-147.phx2.redhat.com [10.3.113.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6269561100;
        Fri, 17 Jul 2020 13:54:13 +0000 (UTC)
Subject: Re: [nfs-utils PATCH 0/5] nfsdcld: Fix a number of Coverity Scan
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     linux-nfs@vger.kernel.org
References: <20200710203700.2546112-1-smayhew@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <16bf22bf-d308-4f78-236e-2c11844a9aa1@RedHat.com>
Date:   Fri, 17 Jul 2020 09:54:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200710203700.2546112-1-smayhew@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 7/10/20 4:36 PM, Scott Mayhew wrote:
> These patches fix some errors in nfsdcld flagged by the Coverity scan
> software.
> 
> Scott Mayhew (5):
>   nfsdcld: Fix a few Coverity Scan RESOURCE_LEAK errors
>   nfsdcld: Fix a few Coverity Scan TOCTOU errors
>   nfsdcld: Fix a few Coverity Scan STRING_NULL errors
>   nfsdcld: Fix a few Coverity Scan CLANG_WARNING errors
>   nfsdcld: Fix a few Coverity Scan CHECKED_RETURN errors.
> 
>  utils/nfsdcld/legacy.c  | 38 ++++++++++++--------------------------
>  utils/nfsdcld/nfsdcld.c |  7 +++++--
>  utils/nfsdcld/sqlite.c  |  5 +++--
>  3 files changed, 20 insertions(+), 30 deletions(-)
> 
Committed... (tag: nfs-utils-2-5-2-rc2)

steved.

