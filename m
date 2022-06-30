Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DE9561524
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jun 2022 10:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbiF3IbY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Jun 2022 04:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiF3IbX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 Jun 2022 04:31:23 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C9F175A0
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jun 2022 01:31:22 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id cb12-20020a056830618c00b00616b871cef3so11837482otb.5
        for <linux-nfs@vger.kernel.org>; Thu, 30 Jun 2022 01:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=nSwjXI9RLIO/9+kKkmmm1khzylH5gkgLY7cyCVJB7Bo=;
        b=HiieRxhNVHCfpV4kHMcHpxs/q827Ae2r8IM40VBGJ+EXCUsTdgGnss1Yz9g1BNCVd7
         FeDhswsR1bbYHutwZBqHSaz0Lb7mm88scfJUVSZjYl7IIarevDMjdou1RGqosJ7hPAah
         C/ar8ou/tXMWdEQFRIKPGYYZVxmgLqa9U4yfK0DClrJFHsyfRHQzgjpKlOMbrxaB/etE
         R3fALgCcbKuQbJYCGwHVCqKn9yfcMRiScgyj+sfN8l+OVkA6p5CPcMGe3yTVbC4jt+xu
         LKQlyqFulv7bIP9KRipJtWwAUpvXuMC7LIyI5CJEeoVD5Vw2MgSz2X9+sr19bA6HEuxG
         +PPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=nSwjXI9RLIO/9+kKkmmm1khzylH5gkgLY7cyCVJB7Bo=;
        b=rkLYI2S227jSVXylnUoI9C8ZCXeQGo6LIrJgjG3g3LafREHbR0AWcsIgxe5WOYz8ri
         7UOlqz0X0lqOkP+16naWZeZdgIaKgJotyimfVS8xKoVflRz6MQp8goQNOHjqxS9/jHoU
         i8rv2y1LCojQFznK8xwlg49ere5lJUzSoI5CSyjLVTEymzDZFDW4Sh9wCfxEXA5mtyU1
         EhoAgtP6zg7TMcfsFsPfNLODX5a9fh1w511aHHhMbLKj0YIFjp/PUBXRov5UwMLBHXrX
         Ip1hd20SzWV2MnW9bhxL0CV2V6BhDkCBlYUwzi7uX7HVAsmOdD5etV0IlvkDoyhFLS/t
         I5dQ==
X-Gm-Message-State: AJIora9zK/y4LYvZ/ZR4YEKyc5rxOQpZikH3v6zCTNYwXs74CgvW/Gul
        i2FXV/0cjOfOb+Dvlty3MEzT9uuxEEc3YhGDNB8=
X-Google-Smtp-Source: AGRyM1uliXs7Qd0G5Ew+J7nMLJcgbtpfkqMOnhFGmpcQGFM/0kuwvvXXuU6lyrtjOyYfbUaF5DojfFlTz2Wyo+a3tOA=
X-Received: by 2002:a9d:4e81:0:b0:616:cde0:3c4c with SMTP id
 v1-20020a9d4e81000000b00616cde03c4cmr3471070otk.61.1656577881587; Thu, 30 Jun
 2022 01:31:21 -0700 (PDT)
MIME-Version: 1.0
Sender: engineerrichardh@gmail.com
Received: by 2002:a05:6838:a82a:0:0:0:0 with HTTP; Thu, 30 Jun 2022 01:31:21
 -0700 (PDT)
From:   Sophia Erick <sdltdkggl3455@gmail.com>
Date:   Thu, 30 Jun 2022 10:31:21 +0200
X-Google-Sender-Auth: 1OogY23NAE7UJ5Akh_z5LJZk_Yo
Message-ID: <CAKMkGm7sxw41Dw_uvwi-0b3o1zX9RbOZbjPKZTBuFEM4=q+Rzw@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello

It is my pleasure to communicate with you, my names is Mrs.Sophia
Erick . I am diagnosed with ovarian cancer which my doctor have
confirmed that I have only some weeks to live so I have decided you
handover the sum of($ 11,000,000.00, Eleven Million Dollars)  I send
you this message because I want to make a donation to you for charity
purposes. I would like to donate funds for charity and investment
purposes to you which you must hasten up hence i will lose all i
labored on earth

Get back to me so I can send you more details about my fund.
Mrs.Sophia Erick
