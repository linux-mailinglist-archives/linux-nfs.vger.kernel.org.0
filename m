Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3C954D4DF
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jun 2022 00:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349844AbiFOW4W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jun 2022 18:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348865AbiFOW4V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jun 2022 18:56:21 -0400
Received: from mail-vk1-xa68.google.com (mail-vk1-xa68.google.com [IPv6:2607:f8b0:4864:20::a68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CA7FD3
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jun 2022 15:56:20 -0700 (PDT)
Received: by mail-vk1-xa68.google.com with SMTP id bj33so6054302vkb.12
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jun 2022 15:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rachmadbagus-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=PojBdEXHZ8rzVaM72fh3gUXF7qKQqZdA90U6AbN86kE=;
        b=eUIuQfllXV6FXtDq+DKwe215iFWqw7W7GC3qjWFZ+sNKoZ+wadtrtlSRyfpaaObRn4
         9bu7hW532qfpALoWiIOuMbbcqH77L2cRXS+VPDs301Dz8miI6ca5pW5kj5vfyBhvponH
         ReN/06WQcQQSdmbxBAEjriZ/QNP4edV1XX8uu0SRAJivy1hg0kT3b2hLXQxb9+MYs9R8
         cHH9mmwXKUTEde+75t+0K/wY5HWSSgaO7G7wurQ9JtM+OeEmn248p6SK6/UZuzW8wBYS
         Ph4K6mkhqgvs08yes2LPCwkTeNhQUFrk6zqy1ENn4aEuRd4fTwMFQrwqlAg5YJq8L0V1
         RqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=PojBdEXHZ8rzVaM72fh3gUXF7qKQqZdA90U6AbN86kE=;
        b=p/4oUGKJxtIXzBo13CcAVbvYRzfhRJDyq/OY29Q9oQkImyI0eJ+PO8mmNQH76p7JRw
         QT4whnKHm7mv6YAfsosNDH9mqHqNB4YoEDMQSP1Aef4bf6avL4hDLU8sEbZYhga2LDUc
         FZ5DSfHQiiF5nHY5Wq7RHlSIVVZB4fKkmXQRCJCfbx/btWT7NQs8NHLkc+QVCmKnyjA5
         zAjNbkOcVOWHjFwKHyJ/CpT/IOOIzXJu9lhQ5oOK8Ax4zE+w0aVQ6hGYDaVU8uBo/Yz2
         HjUB3ir/XNKtibElYLeH1UJdQQ1Rmri5NNaPllXWGP7ucahamt5Ry8ixzSrQESqiIuLE
         1qIw==
X-Gm-Message-State: AJIora9Tv1ilw67l38Mht7i9GakzfQQU32x2eysuZRu2agYzOFHQnaTO
        aEx4WAZqA8WUTzLGRGTHiLhl4qxVHmPsE+4cNr5qVzZzUd7wWg==
X-Google-Smtp-Source: AGRyM1t2kSSdBKZQhx5vPTxeLs0orovL1kb1KMr4mrWqVOyfbYHwn7FLtaGvH4PFQeBa2/yfUN4jYYNsLPUz
X-Received: by 2002:a1f:f40f:0:b0:368:d0d5:edb4 with SMTP id s15-20020a1ff40f000000b00368d0d5edb4mr1309136vkh.21.1655333779559;
        Wed, 15 Jun 2022 15:56:19 -0700 (PDT)
Received: from [103.114.217.161] ([103.114.217.161])
        by smtp-relay.gmail.com with ESMTPS id q8-20020ab02b88000000b003626f896607sm23153uar.6.2022.06.15.15.56.19
        for <linux-nfs@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 15 Jun 2022 15:56:19 -0700 (PDT)
X-Relaying-Domain: rachmadbagus.com
Message-ID: <62aa6393.1c69fb81.7f95d.14a6SMTPIN_ADDED_MISSING@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: URGENT RESPONSE NEEDED
To:     linux-nfs@vger.kernel.org
From:   Mr <admin5@rachmadbagus.com>
Date:   Wed, 15 Jun 2022 22:56:11 -0700
Reply-To: yingyong@winghang.accountant
X-Spam-Status: Yes, score=6.9 required=5.0 tests=ADVANCE_FEE_4_NEW,BAYES_50,
        DATE_IN_FUTURE_06_12,DKIM_SIGNED,DKIM_VALID,HK_NAME_MR_MRS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,URG_BIZ autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a68 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  1.9 DATE_IN_FUTURE_06_12 Date: is 6 to 12 hours after Received:
        *      date
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.8 HK_NAME_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  2.3 ADVANCE_FEE_4_NEW Appears to be advance fee fraud (Nigerian
        *      419)
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'm sorry for sending you this e-mail that ended up in your junk folder as =
unsolicited e-mail. Do you have some time to exchange emails? I want to dis=
cuss a business proposal with you? I know that this business proposal would=
 be of interest to you. For more information please contact me.
