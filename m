Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB607CF9BB
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Oct 2023 14:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345809AbjJSMyH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Oct 2023 08:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345836AbjJSMx3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Oct 2023 08:53:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909C21AC
        for <linux-nfs@vger.kernel.org>; Thu, 19 Oct 2023 05:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697719965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ohIrkU1MoOHwDd3T0XO8iBUZPEwFVjNbUng/BW5LueQ=;
        b=Hgp67Ae30p7K5LI+tQ6LMoDBM2vSdyqQPOMPachOL4xNDONVEKLV1x0tpQ23AnS4340JCI
        mYSjfm2mqnDJ9H49Pc1UhynopPGW4x1oaSkvecRGsG4vp+CEkt+msG6LubaXSzU7HVV87B
        Ty6tr5stCQoUgN6t0wSvPzrZh11+axY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-180-R2tt9PTIOuqSLRbcT2YNdA-1; Thu, 19 Oct 2023 08:52:42 -0400
X-MC-Unique: R2tt9PTIOuqSLRbcT2YNdA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE8743C100A4;
        Thu, 19 Oct 2023 12:52:41 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.48.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D73B9492BEF;
        Thu, 19 Oct 2023 12:52:40 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     trond.myklebust@hammerspace.com, anna@kernel.org,
        oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] NFSv4: Allow per-mount tuning of READDIR attrs
Date:   Thu, 19 Oct 2023 08:52:39 -0400
Message-ID: <4DAD36B1-71D1-486A-8BC2-C3E447D8AB00@redhat.com>
In-Reply-To: <202310191902.6BOby9rI-lkp@intel.com>
References: <bd900de1d19bc56e6df5b44379f373617acc894e.1697577945.git.bcodding@redhat.com>
 <202310191902.6BOby9rI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 19 Oct 2023, at 8:06, kernel test robot wrote:

> Hi Benjamin,
>
> kernel test robot noticed the following build errors:

Thanks robot.   I need to drop the sysfs code without CONFIG_NFS_V4.

I will send another version.

Ben

