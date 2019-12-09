Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63A171170F3
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2019 16:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfLIP54 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Dec 2019 10:57:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49811 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726197AbfLIP54 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Dec 2019 10:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575907076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k4URFb9kQYJLX3wJ4o61TSmtgg7XF8TjETAx/SsZT4Y=;
        b=fwF1pkN1Z9VE5NTtS2mf8a6D8FQSBfyR28ZLLk33xmsbJnOY8CgJsTHusNVIO52GRGZPu0
        yhMTr0eA3sD+1KdlSmf2dMaQUVpH2mfjWSuV74lngw0Q+o3ZMgF900Q+5JXThf0yvwpZHU
        F7ibLA1K9xOKnXGX0YupvLTKTn6/Img=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-FarUkbsSNvC9N_f153NYjg-1; Mon, 09 Dec 2019 10:57:54 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E60AD10071FF
        for <linux-nfs@vger.kernel.org>; Mon,  9 Dec 2019 15:57:53 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-120.phx2.redhat.com [10.3.117.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 868EE619F2;
        Mon,  9 Dec 2019 15:57:53 +0000 (UTC)
Subject: Re: [nfs-utils PATCH 0/3] A few small nfsdcld fixes
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     linux-nfs@vger.kernel.org
References: <20191126154718.22645-1-smayhew@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <7e2260b1-d479-30d1-6aed-95a47b41b323@RedHat.com>
Date:   Mon, 9 Dec 2019 10:57:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191126154718.22645-1-smayhew@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: FarUkbsSNvC9N_f153NYjg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 11/26/19 10:47 AM, Scott Mayhew wrote:
> The first two patches fix problems I noticed when trying to build an rpm
> package w/ nfsdcld enabled.  The third patch fixes an issue I found
> trying to use nfsdcld on a ppc64le system.
> 
> Scott Mayhew (3):
>   nfsdcld: don't override sbindir
>   systemd: install nfsdcld.service when nfsdcld is enabled
>   nfsdcld: getopt_long() returns an int, not a char
> 
>  systemd/Makefile.am       | 5 +++++
>  utils/nfsdcld/Makefile.am | 4 ----
>  utils/nfsdcld/nfsdcld.c   | 2 +-
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 
Series committed... (tag:  nfs-utils-2-4-3-rc3)

steved.

