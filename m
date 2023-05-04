Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C0D6F77A0
	for <lists+linux-nfs@lfdr.de>; Thu,  4 May 2023 23:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjEDVAo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 May 2023 17:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjEDVAb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 May 2023 17:00:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF00612E96
        for <linux-nfs@vger.kernel.org>; Thu,  4 May 2023 13:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683233921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=09vtGcenriYwMBY4b1dJZoHLxKlhUWJ1mKdl9tNt1Uc=;
        b=Xp6S82HWOk3tPHBNu5W+P24K+Xn/zaf6COcgdjVAi5mkScwilASFw3buqtcfezxO6RBOML
        gKURICy10qriLx2pRTihVXqx+9vEWTqetTNAQgxhGuv37lyOBF5lanvGhexCTlObkjBJ76
        haCYuSfsQUb5nJNCEJMBMBOqSdmPXE8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-CcVbN-I0Nj6K7b4sKCJQVw-1; Thu, 04 May 2023 16:58:30 -0400
X-MC-Unique: CcVbN-I0Nj6K7b4sKCJQVw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E41EF886462;
        Thu,  4 May 2023 20:58:29 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D46B2166B30;
        Thu,  4 May 2023 20:58:29 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH] NFS: add a sysfs file for enabling & disabling nfs
 features
Date:   Thu, 04 May 2023 16:58:28 -0400
Message-ID: <39502EC7-504B-49A4-B0E2-728231F87984@redhat.com>
In-Reply-To: <CAFX2Jf=rcZfTRXNOoiZj91=pTWQEPrkq8VqBHY3AyC7rBe8sew@mail.gmail.com>
References: <20230421182738.901701-1-anna@kernel.org>
 <B1DC5ECE-ECA8-4282-92EB-7272D091AC87@redhat.com>
 <CAFX2Jf=rcZfTRXNOoiZj91=pTWQEPrkq8VqBHY3AyC7rBe8sew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 4 May 2023, at 16:51, Anna Schumaker wrote:
>
> Do you want a v2 without the readdir plus line, and with the v4.2 restriction?

Sure, that'd be great!

Ben

