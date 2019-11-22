Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE7510753F
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Nov 2019 16:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfKVPyg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Nov 2019 10:54:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50900 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726546AbfKVPyg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Nov 2019 10:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574438075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3eWi5acOqqX+jJrRpSwJ0uNIiljhJ3OsJnI5IWgjSig=;
        b=fD8iDjU2ZBGLqXh4fSWtiaCSOEOwH6ZBTOrnbAv/VGpBejwioUUfN/xpwaW2mJRQSc21C3
        cIOjfXtgeWDc/wdRar9FgeJnTG8FqEKiSzotJEjgzr2+Mo3a4krmWznCTNJz5hyd1X30FP
        rzuj98Oey4WQTAfz9Rc/sS1SVn+GvRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-0Vvs-wqpPriis8oSIOOEdQ-1; Fri, 22 Nov 2019 10:54:33 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D5AB1005502;
        Fri, 22 Nov 2019 15:54:32 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-117-36.phx2.redhat.com [10.3.117.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3DBEF60179;
        Fri, 22 Nov 2019 15:54:32 +0000 (UTC)
Subject: Re: [patch] fix compilation with -Werror=format on i586
To:     Guillaume Rousse <guillomovitch@gmail.com>,
        linux-nfs@vger.kernel.org
References: <d21f152d-1d9d-01c2-900e-39c67eb2cef3@gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <4b47a9cd-5bec-518c-2282-bb020f92708e@RedHat.com>
Date:   Fri, 22 Nov 2019 10:54:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <d21f152d-1d9d-01c2-900e-39c67eb2cef3@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 0Vvs-wqpPriis8oSIOOEdQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

On 11/21/19 5:59 PM, Guillaume Rousse wrote:

A couple things... In the future please in line the patch
instead of attaching it and please use the appropriate
Signed-off-by: line

Half of your patch already existed due to commit a20dbec9

The rest of the patch I did Commit (tag: nfs-utils-2-4-3-rc2)

steved.

