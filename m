Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31433140C8A
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2020 15:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgAQOcR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Jan 2020 09:32:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22609 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726827AbgAQOcR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Jan 2020 09:32:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579271535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+JsmTh26idCccXQ/oYTZjUrAi/FkH1cHDjHi1212igI=;
        b=OQ/lbRNhRge0pzpFzhuwSKuFK32dlgErjargGXL/713/RqOwvcd50UxOwExiljlKAQCr+6
        k+jUD6WpbF5ZuEK+lW3XhCZOb92qlUk7nFmYUkz9HZwBjF5/JE2vQcdTTzgSLRLED4fY8e
        8vnABFEXbFMOv/ackFC4XDDKS7Nej1Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-zFXVokCgOTWIIR5AUL7Q_g-1; Fri, 17 Jan 2020 09:32:11 -0500
X-MC-Unique: zFXVokCgOTWIIR5AUL7Q_g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57643107ACC7;
        Fri, 17 Jan 2020 14:32:10 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-35.phx2.redhat.com [10.3.117.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC9FD1001901;
        Fri, 17 Jan 2020 14:32:09 +0000 (UTC)
Subject: Re: [nfs-utils PATCH 0/3] bump rpcgen version and silence some
 warning
To:     Petr Vorel <petr.vorel@gmail.com>
Cc:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-nfs@vger.kernel.org, Mike Frysinger <vapier@gentoo.org>
References: <20200113162918.77144-1-giulio.benetti@benettiengineering.com>
 <30b28d4e-71a5-f412-23e7-877a4eff17bd@RedHat.com>
 <fdbade7a-f8f6-16b1-1a18-e9742b9a0aa0@benettiengineering.com>
 <6fdcbba5-e965-fe69-569b-7f32005ce1bf@benettiengineering.com>
 <c1e96762-0f3a-b465-da1b-f7bc7a687948@RedHat.com>
 <20200117063032.GA6351@dell5510>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <818c66c5-6f8b-927f-229e-52a00f50c682@RedHat.com>
Date:   Fri, 17 Jan 2020 09:32:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200117063032.GA6351@dell5510>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey Petr,

On 1/17/20 1:30 AM, Petr Vorel wrote:
>>> If you have the chance to commit before releasing version it would be great!
>> Your patch on my radar... but... conflicts  with Petr's cross-compilation patch
>> https://lore.kernel.org/linux-nfs/20200114183603.GA24556@dell5510/T/#t
> 
>> That patch causes an automake warnings which is something I'm trying to avoid.
> 
>> No worries... I will not do a release w/out your patch.... or something close to it. 
> 
> Giulio, thanks for your patch. I'll have a look on it over a weekend.
> Maybe Mike's cross-compilation patch is really not needed.
> 
Thanks... for taking a second look!!

steved.

