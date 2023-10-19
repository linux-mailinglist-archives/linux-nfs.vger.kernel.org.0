Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1737D0091
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Oct 2023 19:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbjJSRc2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Oct 2023 13:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbjJSRc2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Oct 2023 13:32:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7028C106
        for <linux-nfs@vger.kernel.org>; Thu, 19 Oct 2023 10:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697736700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bqwVYrA5zY7g/jU/ZPx2G6lru7BCsrJ2bs4lTzgzsU0=;
        b=DVsNnagHuqSMAFKPhDt2eyBzUQrX7MYxpBZmKhRysK8GYOgcSOKMh/E4Zex9BjkTBqRQMe
        R4OTvYmoSMID0eQEV4RGyrweaViIQFmGlDTUGaFbAh2/Yemj1icyshWDd93CdW2nmo6kXK
        KFQqGjRzweFzqF0FjHP4rn3QkXVlXPI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-yDo58ZhGMuqWAtVHi2u5XQ-1; Thu, 19 Oct 2023 13:31:38 -0400
X-MC-Unique: yDo58ZhGMuqWAtVHi2u5XQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E4531C0652E;
        Thu, 19 Oct 2023 17:31:37 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B0737C15BB8;
        Thu, 19 Oct 2023 17:31:36 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] NFSv4: Allow per-mount tuning of READDIR attrs
Date:   Thu, 19 Oct 2023 13:31:35 -0400
Message-ID: <957A3D2C-2313-4D21-B166-20DA5F754A07@redhat.com>
In-Reply-To: <12d7225becae370a923bec807a140f8e87c0eca0.camel@kernel.org>
References: <cover.1697722160.git.bcodding@redhat.com>
 <fbd3cd01c28e8c132058ae16b22eeae5ddaa8178.1697722160.git.bcodding@redhat.com>
 <12d7225becae370a923bec807a140f8e87c0eca0.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 19 Oct 2023, at 12:55, Jeff Layton wrote:

> If you are going to add this, then I think the consensus from
> yesterday's comments was to put it behind a new Kconfig option. Maybe
> there could be a new CONFIG_NFS_TWEAKS or something that exposes this
> interface (and other stuff we're not sure about making generally
> available).

Right.  I was hoping the discussion would continue, and this version was
just to make the robot happy.  I'll send it again with it config-ed out in a
few days if there's no other discussion.

Ben

