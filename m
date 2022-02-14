Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88604B4F09
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Feb 2022 12:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352642AbiBNLnV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Feb 2022 06:43:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352797AbiBNLnN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Feb 2022 06:43:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F0656C92B
        for <linux-nfs@vger.kernel.org>; Mon, 14 Feb 2022 03:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644838495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ZPN7HBnFfUX9sAa9QDRNYhv8RqYLNXjdEzUKVDHdLg=;
        b=LzGrUQvV+n64VYNdCd98QwKe/4Y7ncbfiIHsE5kgVaNCKTr2cM3z/EGm6IYwR1ux3D5AFD
        1ilFwucr69PZRNih34/126ZfU+HinQMt4fm48oiO6oXQKA89Po/tNMopLdWv/gEjsPRDzk
        ShhIftCUWON8viJLIURKBbWbwZ0HZnI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-3LYgPqGXPqCjp9nVddQ_GQ-1; Mon, 14 Feb 2022 06:34:52 -0500
X-MC-Unique: 3LYgPqGXPqCjp9nVddQ_GQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E83A91853028;
        Mon, 14 Feb 2022 11:34:50 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 614F0108647A;
        Mon, 14 Feb 2022 11:34:50 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     NeilBrown <neilb@suse.de>
Cc:     "Trond Myklebust" <trondmy@hammerspace.com>, steved@redhat.com,
        linux-nfs@vger.kernel.org
Subject: Re: [nfs-utils PATCH] nfs4id: a tool to create and persist nfs4
 client uniquifiers
Date:   Mon, 14 Feb 2022 06:34:49 -0500
Message-ID: <2B965E03-552B-4A5A-85E7-53E65729198D@redhat.com>
In-Reply-To: <164479465866.27779.3680126986096452561@noble.neil.brown.name>
References: <c2e8b7c06352d3cad3454de096024fff80e638af.1643979161.git.bcodding@redhat.com>
 <6f01c382-8da5-5673-30db-0c0099d820b5@redhat.com>
 <0AB20C82-6200-46E0-A76C-62345DAF8A3A@redhat.com>
 <6cfb516d-0747-a749-b310-1368a2186307@redhat.com>
 <164444169523.27779.10904328736784652852@noble.neil.brown.name>
 <39e7bba4243eb2f16d99fefb43fef6b3ff741f87.camel@hammerspace.com>
 <164445109064.27779.13269022853115063257@noble.neil.brown.name>
 <6BAAA0D0-7212-480F-9C33-DA1F656FF09F@redhat.com>
 <164453369792.27779.10668875903268728405@noble.neil.brown.name>
 <299337F3-E83F-49EC-BB24-C9B859C9FB6D@redhat.com>
 <164479465866.27779.3680126986096452561@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 13 Feb 2022, at 18:24, NeilBrown wrote:
> Document the requirement and make it "someone elses problem".
> Your kernel patch to provide a random default mean a lack of
> configuration will only hurt the container which lacks it - which nicely
> localises the problem.

I thought of another approach which was to have either mount.nfs or the
kernel emit a warning if a client is not uniquified.

Ben

