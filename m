Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BE852EC5E
	for <lists+linux-nfs@lfdr.de>; Fri, 20 May 2022 14:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349379AbiETMld (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 May 2022 08:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349575AbiETMlb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 May 2022 08:41:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 451DC18B01
        for <linux-nfs@vger.kernel.org>; Fri, 20 May 2022 05:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653050489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N22RTNjNiOoeCyukDfey1BC2Fv6UeTKWJCGnb5nPt1Y=;
        b=c0VUf9Y7n93KeYsd/PieH5Z9JtqFNO5gB9dNnxAkCMF3fFhBhV/mNeQ4dqWpKoOYwOZVNW
        6TL8bhEHBN/ok/WGlYeZL3ITm+pislD2pEDw97eeSPwBjlLPncBwRjbayoJWIECVK5hA1H
        V025N9/M9uHEqkfX0iJohBdCGeLXmYY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-KphpiQiNPXSVG0ro4fr9xw-1; Fri, 20 May 2022 08:41:27 -0400
X-MC-Unique: KphpiQiNPXSVG0ro4fr9xw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DECE3C138BE;
        Fri, 20 May 2022 12:41:27 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-66.rdu2.redhat.com [10.10.64.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C62AB1121319;
        Fri, 20 May 2022 12:41:26 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Javier Abrego Lorente" <javier.abrego.lorente@gmail.com>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs: removed goto statement
Date:   Fri, 20 May 2022 08:41:26 -0400
Message-ID: <B70C3673-8CBF-414D-9D8A-BAD4F30FA9D9@redhat.com>
In-Reply-To: <CAPsi6X+M11NttnV80dYhA=0t=ZGH1YR1ZGssEZvz+kN8RYTcbw@mail.gmail.com>
References: <20220520115714.47321-1-javier.abrego.lorente@gmail.com>
 <CAPsi6X+M11NttnV80dYhA=0t=ZGH1YR1ZGssEZvz+kN8RYTcbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 20 May 2022, at 8:00, Javier Abrego Lorente wrote:

> final version, I promise.

Javier, please read "7) Centralized exiting of functions" in
Documentation/process/coding-style.rst.  The maintainers are unlikely to
take this patch because it doesn't (my opinion) improve the readability, and
removing a goto isn't a valid reason on its own.  The use of goto is an
acceptable practice in the linux kernel for some patterns.

Ben

