Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477C95B8E37
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Sep 2022 19:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiINRdj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Sep 2022 13:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiINRdi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Sep 2022 13:33:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACED7F256
        for <linux-nfs@vger.kernel.org>; Wed, 14 Sep 2022 10:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663176817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6zsayO2Evg5+JAUvw4gtw1yV5JHcMAjOwPEYghV0Qm8=;
        b=W6nDa7U9trbPPhF0nXKL7e4lVdHJxnSsQRB0HlbYoGwreMmbw0wNogEDbPY+k3Q+HyamDi
        joczgspmGH1T6jX2cqZEB0IHWU67WIwW4xkBe1cGDQyufZ5GU1XPuZOUzsRhElc08qc0gN
        oHSvtRmR7WY3n2aDMVpraPw9sHCEabg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-FncgrNQ0P7OeOkw3ppN5xw-1; Wed, 14 Sep 2022 13:33:35 -0400
X-MC-Unique: FncgrNQ0P7OeOkw3ppN5xw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A4DA855304
        for <linux-nfs@vger.kernel.org>; Wed, 14 Sep 2022 17:33:35 +0000 (UTC)
Received: from plambri-t490s (unknown [10.33.36.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AF052166B26;
        Wed, 14 Sep 2022 17:33:34 +0000 (UTC)
Date:   Wed, 14 Sep 2022 18:33:31 +0100
From:   Pierguido Lambri <plambri@redhat.com>
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] nfs4_setfacl: add a specific option for indexes
Message-ID: <20220914173331.kxmc6lyr72zjpgym@plambri-t490s>
References: <20220815083908.65720-1-plambri@redhat.com>
 <dff91106-4869-c20b-502b-4d3e0e9ac536@redhat.com>
 <20220825074345.cexc7kgaljnuqf66@plambri-t490s>
 <fcb3e029-5754-d8d4-cc3c-a8b833db03c0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcb3e029-5754-d8d4-cc3c-a8b833db03c0@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 13, 2022 at 11:59:31AM -0400, Steve Dickson wrote:
> 
> FYI... I'm going to wait for the man page before I
> do the commit.
> 
Sorry for the delay, I just sent a new version with a couple of fixes and
the man page.

Thanks,

Pier

