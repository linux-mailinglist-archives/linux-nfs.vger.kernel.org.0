Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BD8257B8E
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Aug 2020 16:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgHaO7x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Aug 2020 10:59:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37673 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbgHaO7s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Aug 2020 10:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598885987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SGKkBRx2X2c4kqxAWKe1E8dQFFxz1tEDVcsZgrSOY0w=;
        b=hdmh4eJnAS7T5btWyDGRx7oS3kyHiad6r+bCmITRyWVrBnsLOhFALQw9t1NmOJBGENNXJ1
        IcA3URZKvwVJyBLjpCgO5tdu0PMJPKnZjCzjZDmJYgy6Z4LmkldZZLEIcrl/i3KFyln7xa
        lbOeWxaWgi1IiC6NhTJ5XzUnjv03u1k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-Vh5kN6AHPyCm3SZLY9mpwQ-1; Mon, 31 Aug 2020 10:59:44 -0400
X-MC-Unique: Vh5kN6AHPyCm3SZLY9mpwQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F9DD801AAC;
        Mon, 31 Aug 2020 14:59:43 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-190.phx2.redhat.com [10.3.113.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38B707A5E0;
        Mon, 31 Aug 2020 14:59:43 +0000 (UTC)
Subject: Re: [PATCH nfs-utils] Convert remaining python scripts to python3
To:     NeilBrown <neil@brown.name>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <87zh6iqtm9.fsf@notabene.neil.brown.name>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <f028aa18-6c5a-4ff0-3714-14a396cf20c4@RedHat.com>
Date:   Mon, 31 Aug 2020 10:59:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87zh6iqtm9.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/25/20 5:54 PM, NeilBrown wrote:
> 
> nfs-utils contains 4 python scripts, two request
>  /usr/bin/python3
> in their shebang line, two request
>  /usr/bin/python
> 
> Those latter two run perfectly well with python3 and as python2 is on the
> way out, change them so they requrest /usr/bin/python3.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
Committed... (tag: nfs-utils-2-5-2-rc4)

steved.
> ---
>  tools/mountstats/mountstats.py | 2 +-
>  tools/nfs-iostat/nfs-iostat.py | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/mountstats/mountstats.py b/tools/mountstats/mountstats.py
> index 1054f698c8e3..00adc96bafeb 100755
> --- a/tools/mountstats/mountstats.py
> +++ b/tools/mountstats/mountstats.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python
> +#!/usr/bin/python3
>  # -*- python-mode -*-
>  """Parse /proc/self/mountstats and display it in human readable form
>  """
> diff --git a/tools/nfs-iostat/nfs-iostat.py b/tools/nfs-iostat/nfs-iostat.py
> index 5556f692b7ee..6e59837ee673 100755
> --- a/tools/nfs-iostat/nfs-iostat.py
> +++ b/tools/nfs-iostat/nfs-iostat.py
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python
> +#!/usr/bin/python3
>  # -*- python-mode -*-
>  """Emulate iostat for NFS mount points using /proc/self/mountstats
>  """
> 

