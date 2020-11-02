Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809622A3026
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 17:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgKBQmn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 11:42:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20057 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727134AbgKBQmn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 11:42:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604335362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=inxxV8Xl3+G9MYOyzRRPDfhKsUuLxeZmCwk7U8WRpwE=;
        b=FWp43K/irvLuBD9K9xdXP2G1g6h8gGimmcOntU6WpmQg59Xh2mTbnad6znrZHct0+732Pz
        QKcO7ck+81S7wu8fRZoAlCfLI4+IP6XHjitIHlnmjPWuUMKUV8B5INX/+nDzHOzjrsxPHD
        a4A8ZG7Rbhy4opFKQVDinUhOdy04acs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-Yb2a-PChNM-N-ZsXf1Ylkg-1; Mon, 02 Nov 2020 11:42:41 -0500
X-MC-Unique: Yb2a-PChNM-N-ZsXf1Ylkg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06B7E804001
        for <linux-nfs@vger.kernel.org>; Mon,  2 Nov 2020 16:42:40 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-8.phx2.redhat.com [10.3.113.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B58DD5B4D3;
        Mon,  2 Nov 2020 16:42:39 +0000 (UTC)
Subject: Re: [RFC PATCH 0/1] Enable config.d directory to be processed.
To:     Alice Mitchell <ajmitchell@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <20201029210401.446244-1-steved@redhat.com>
 <338aeb795a31c2233016d225dc114e33d02eb0cb.camel@redhat.com>
 <6f3caf91-296c-0aa8-ba41-bc35d500adaa@RedHat.com>
 <4836616f-3aa6-d0bd-22db-cd7fecf4dce9@RedHat.com>
 <a42154ffeb06a21590db01ab651870040597571c.camel@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <99ef399b-7c8a-e440-ce85-463a8ecf3097@RedHat.com>
Date:   Mon, 2 Nov 2020 11:42:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <a42154ffeb06a21590db01ab651870040597571c.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey!

On 11/2/20 10:05 AM, Alice Mitchell wrote:
> That should work yes, although I am still dubious of the merits of
> replacing the single config file with multiple ones rather than reading
> them in addition to it. Surely this is going to lead to queries of why
> the main config file is being ignored just because the directory also
> existed.
Isn't that how Ansible works? They drop in its own config file assuming 
main config file is ignored (or even removed)?
 

> 
> I also have concerns that blindly loading -every- file in the directory
> is also going to lead to problems, such as foo.conf.rpmorig files and
> the like.  This is why i suggested a glob would be a better solution
Maybe used mrchuck's suggestion only process *.conf files? 

steved.

