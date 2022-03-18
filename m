Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E184DDC8C
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Mar 2022 16:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbiCRPPY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Mar 2022 11:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237829AbiCRPPX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Mar 2022 11:15:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7CDD237E1
        for <linux-nfs@vger.kernel.org>; Fri, 18 Mar 2022 08:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647616442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TeM/qoqCyLjeTTNuOfjRyXfY+oaVdE7zSQUwVoYfWv4=;
        b=BJdfx61+WxT9ng4DnrAoSpRdGbXY3RTiPZu2tFQZpXu3k5VaYEbjzRxakkN+euVmSjyERJ
        frsqcJUymn0X3p7s16sDenVH2L2nNcoEtoEPMVHYwXrW3+NhUBOeTYKi2ccrmPwd0vPTfC
        zYTNUcHcex6UD8a7F2iLUl04/XRm+yM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-141-nLVtOgDiPP6nAxO8QTT7zw-1; Fri, 18 Mar 2022 11:14:00 -0400
X-MC-Unique: nLVtOgDiPP6nAxO8QTT7zw-1
Received: by mail-ed1-f72.google.com with SMTP id b71-20020a509f4d000000b00418d658e9d1so5011813edf.19
        for <linux-nfs@vger.kernel.org>; Fri, 18 Mar 2022 08:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TeM/qoqCyLjeTTNuOfjRyXfY+oaVdE7zSQUwVoYfWv4=;
        b=2/71TZw86yuyRFByiUUhczH/vlgYSh7SqsAxbuamwlYy2alSMsjwxMx+0CawWNHdHt
         3C9ZEsC49O4D5NGxcKmkhvQb96lafj1KWUJUNmT9bRJj4l795SBhtYWhyvR7y7WTkl9a
         lUlfXsXlL2QRucriiRhjUsi9npf0ip84KEmH+0H6U3s8kh51FhOGnkvYiNRq+CaW3ZFy
         5B1hqTp0zJwXBUrMDys1s1j7ARonWFlojjNwnxdH159hHuIKxIY8Irk/LJhPTFYBPVGk
         Njig+XZ/LlvsfsRG9MoLr4iH4ma73dWHYHHf38DJMp8BhycwwvrRO+kyIBE1WdCdROfg
         z4wQ==
X-Gm-Message-State: AOAM531JIx67KZkD55C0si008YpSPeWbF0SmgSNF+rScLovi0mvqiRWZ
        ZKCtAcn6BJO0AdzcPctP1I85vMU7vvn9ZLBB/uPh+yTQTeoN7ZdtPbj3u0DZ06MHj7CgKTN5sNr
        j56YS3glOKyTlhz+TFDmA7VUnArMGqGaCj1r6
X-Received: by 2002:a17:907:2cc3:b0:6da:e6cb:2efa with SMTP id hg3-20020a1709072cc300b006dae6cb2efamr9229355ejc.169.1647616439101;
        Fri, 18 Mar 2022 08:13:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyYgH2Fv5NdUpnawoKTpfQ/xMEi/sPi/D+tRYo1vl2PcpRg07tvTzu0ceD0+F1GWjCp0IUSXOBe/OXFaUTDhU=
X-Received: by 2002:a17:907:2cc3:b0:6da:e6cb:2efa with SMTP id
 hg3-20020a1709072cc300b006dae6cb2efamr9229341ejc.169.1647616438929; Fri, 18
 Mar 2022 08:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220311190617.3294919-1-tbecker@redhat.com> <f6a1e306-211a-25d0-50c5-63c631ca1e47@redhat.com>
In-Reply-To: <f6a1e306-211a-25d0-50c5-63c631ca1e47@redhat.com>
From:   Thiago Becker <tbecker@redhat.com>
Date:   Fri, 18 Mar 2022 12:13:47 -0300
Message-ID: <CAD_rW4XEooKeN2ttG-tjxGfwybjRRhs_QsLAwSoqDFDbp7GAKA@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 0/7] Introduce nfs-readahead-udev
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com,
        anna.schumaker@netapp.com, Olga Kornievskaia <kolga@netapp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 15, 2022 at 8:54 AM Steve Dickson <steved@redhat.com> wrote:
> My apologies for waiting late on this... I was on PTO.
>
> I really don't like the name of the is command. It
> does not follow any of the naming conventions we used in the
> past... Can you please rename the command to nfsrahead.

I have this on my git, I'm just waiting for more comments to release a
new version.

> tia,
>
> steved.

thiago

