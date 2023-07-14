Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1993E753F2E
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jul 2023 17:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjGNPlw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jul 2023 11:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjGNPlv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jul 2023 11:41:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3FC1980
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jul 2023 08:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689349266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QQDmndQXJBRzMQF4bWvdVrlGRFlRIhD+9aDMctvo/eQ=;
        b=PsvtKIR1amyQtkP21moBPgMUwgrcTyPc9huGb32m4F2Xy0ZgvlcaZTuqfHnjwS+1RGVTXo
        9xoktP6CTNRgRvSumFPABu3c9ZCOGb6hpcUp0KdetybO/qmDxycTL/DaybBgFaOzow8Bi6
        0KfKjiH2Ult3UJVuCOY+GESoBgldk08=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-9wgu3TB3OgW_xQZSyf_zYw-1; Fri, 14 Jul 2023 11:41:03 -0400
X-MC-Unique: 9wgu3TB3OgW_xQZSyf_zYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62559800C7F;
        Fri, 14 Jul 2023 15:41:01 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A1C3210C9D;
        Fri, 14 Jul 2023 15:41:00 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSv4.1: fix zero value filehandle in post open
 getattr
Date:   Fri, 14 Jul 2023 11:40:59 -0400
Message-ID: <C4261248-D6E9-46FC-8461-8233DF0B0BAF@redhat.com>
In-Reply-To: <CAN-5tyGiiSr+jkh=WL_C4=wBAfZUiQZVsJoVxn0Sxg=yK+TA9g@mail.gmail.com>
References: <20230713195416.30414-1-olga.kornievskaia@gmail.com>
 <A0663B9C-F005-4089-ABD6-542F77EE43ED@redhat.com>
 <CAN-5tyGa1dV1A5RgZsMCQzFHDV63=LDJq0DTpg8aJ=UCO+k+Og@mail.gmail.com>
 <A05D90E0-6D74-4948-B948-852B1448DD3C@redhat.com>
 <CAN-5tyGiiSr+jkh=WL_C4=wBAfZUiQZVsJoVxn0Sxg=yK+TA9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 14 Jul 2023, at 9:57, Olga Kornievskaia wrote:
>
> I guess I don't understand what's the problem with the current
> approach which is simple.

No problem - I'm just bad at code review.

I was trying to get my head around why the o_arg->fh couldn't be used, and
then wondering why you were hitting that warning.

Then I worried that the opendata was already freed at the point the getattr
was trying to use it again, and because its a codepath I can't exercise
easily my normal approach of just throwing in debug statements didn't work -
but I think the opendata is still there because _nfs4_do_open has it pinned.

Ben

