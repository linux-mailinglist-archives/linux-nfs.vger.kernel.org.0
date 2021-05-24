Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C2638E57C
	for <lists+linux-nfs@lfdr.de>; Mon, 24 May 2021 13:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhEXLb7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 May 2021 07:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33875 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232070AbhEXLb7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 May 2021 07:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621855830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r1jPoCyFjv6h1Pb9likRFn4mzU5mAIFLhUsNx0MigOY=;
        b=azNTmN3I7GNGE290n5GVntAeZ+fNmtll2qnc8Q/8HO52G1I5oHDzEsFx6fEKNnbn30Anra
        cZslDVdMvHofpe/CWJ5RiTWLeT4mk5CJh8QMNBORhUZt24+KluQw20mJn4vmqwxeyBzPzt
        NPsD6ODsUfO7Bqwh4UdcrQRv9Hk3hOg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-RC0bheiAO12NXaMjH8DA7g-1; Mon, 24 May 2021 07:30:28 -0400
X-MC-Unique: RC0bheiAO12NXaMjH8DA7g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3434180FD65;
        Mon, 24 May 2021 11:30:26 +0000 (UTC)
Received: from [10.10.66.2] (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 68CB11724D;
        Mon, 24 May 2021 11:30:26 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Jason Keltz" <jas@eecs.yorku.ca>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: ksu problem with sec=krb5 and nfs
Date:   Mon, 24 May 2021 07:30:25 -0400
Message-ID: <7714ABF4-E9CD-424B-BF7F-6F1B91F58C2B@redhat.com>
In-Reply-To: <abbd93ac-4a68-a471-fbb4-a9baf05b89c9@eecs.yorku.ca>
References: <abbd93ac-4a68-a471-fbb4-a9baf05b89c9@eecs.yorku.ca>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 22 May 2021, at 10:47, Jason Keltz wrote:

> Can someone help me understand the issue, and whether there is a solution?

Don't you want ksu to write its target cache to /tmp/krb5cc_1011 so rpc.gssd
can find it?  Why isn't that happening?

Ben

