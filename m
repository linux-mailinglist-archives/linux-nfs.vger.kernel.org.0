Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F64C4D8568
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Mar 2022 13:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbiCNMtu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Mar 2022 08:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241901AbiCNMsP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Mar 2022 08:48:15 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70CE2ADE
        for <linux-nfs@vger.kernel.org>; Mon, 14 Mar 2022 05:42:51 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j17so23822085wrc.0
        for <linux-nfs@vger.kernel.org>; Mon, 14 Mar 2022 05:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=c0efiEkVxtTkTFENAKnUNGf6D7Eoa+H/DnhrKy6xKHg=;
        b=GH/UfRzxN4Q3s67H7ukUGF5eSERRoRG7Od11IUnz9bBYrw3NoZFnYC5FtzaL9g0Yn0
         kS8qUFP3zfV19m/YphdmSGVb/ZCt7lDo3HCNTZNEc/E+Gk6RS+mCyvBmAw6rGWuNpJ+9
         kjBHMd+3CAs5RshrAOaBOjbG53jlVV0QBLu37rXMnz4jXviGPqqacbAPQRncnZQOlZ/s
         QrBvQ7F72lHFyQrQCcGx6O8YHBwlxTNAvIdmJqr7+eZrNgkMBJ+a4gd88qmlJHpPppCK
         EbY4rFnhjh0frZb0vRo4+IzXFOBvNvTZABFrvfWUkx6Q5XTeTPm34nKXZ83nDwg0sYai
         XmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=c0efiEkVxtTkTFENAKnUNGf6D7Eoa+H/DnhrKy6xKHg=;
        b=uJCNPTTbgqmyPTO73/92fLTsj9xVv76uUla0AZnuBt3Y1pxQFGtqbw1cqlaEi94Z1F
         SAFQfBpaOM8qrAlgAzdlyJvORKOx7pi3xtCIcCvL/za3FrV7hw5DSyKxMbG3ZthhFznn
         cI12GrjLwQQJ8mum6Z/8JHvYqc/R5nJbLH87nyatK3WejXaKroN+Zj7y2HLsWODnxtCh
         4RgzmU5vtbr0i0Bqb5FdPYqGzqVfhifNXY6K8j1PttFOsnxVidYJKaOkJDHGH8eaxszY
         njcmDKATMlQbxUtvvnOkyozjI4qeE2gR8jSfC/PAaEbkL9YngiSDX9khgT/ykD6Sv2HW
         TfMg==
X-Gm-Message-State: AOAM532fjIReuiLYqSTC4wgWnQisUAe4lFOuqcd5kg5ls7soiepzAo70
        TMecAr/kfMqbeSPPtbI+dGOpd3GSvdzBWaI/tdg=
X-Google-Smtp-Source: ABdhPJzldOOryepAqzCjRdXnaWWWXADOh20+aqXiUEVOdZUBPxEYxD/+2ZOSULcXkDkBk8VRyCLjucSMznkrAds6fgs=
X-Received: by 2002:adf:f150:0:b0:1f0:6925:722 with SMTP id
 y16-20020adff150000000b001f069250722mr16032477wro.465.1647261769614; Mon, 14
 Mar 2022 05:42:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:6489:0:0:0:0:0 with HTTP; Mon, 14 Mar 2022 05:42:49
 -0700 (PDT)
Reply-To: anwarialima@gmail.com
From:   Alima Anwari <khuntamar5@gmail.com>
Date:   Mon, 14 Mar 2022 12:42:49 +0000
Message-ID: <CAOdLAAJcegRwZjoGmomemNYOWPvpuHuix3UpNYOdbHMauOA1rg@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

-- 
Hello dear friend, i'm Alima Anwari from Afghanistan, please reply
back to me and have an urgent issue to share with you. I will be waiting
for your response.
Thanks.
Alima.
