Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35A86614C5
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Jan 2023 12:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbjAHLaL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Jan 2023 06:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjAHLaG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Jan 2023 06:30:06 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5936CD2DE
        for <linux-nfs@vger.kernel.org>; Sun,  8 Jan 2023 03:30:00 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id c17so8491217edj.13
        for <linux-nfs@vger.kernel.org>; Sun, 08 Jan 2023 03:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcpM41K3Tg/Gq2Sy2fOw39ukTQf5X/VzmfsS+yU67xU=;
        b=CBHoltcPCly7GiqaZisHIdHagk3j88LH6gwUStENc7TmK8kPc76KHKYcnJY6iDZZMK
         zeZqsA1ff0w5XpZ+4glFWl1GyviVBRgntqmHO/VUY/3QAM/4BEqATrvB9QC5pUObgew4
         RetoWbsbhE7vvZNjnWF1ntu6AKusNAqL9LcfNQoL746mMOo+IU62G6AnwXIE1R5hrOEj
         dbBWRzUB2Prz7lzjeUBado8dQNU+NHa8UO7MHqA6YBhg8o5885TQyc+TTd+AHeQCxRmz
         W39GCfWxEXJKc5WGkow93s6w0rATs6Z97vg48xEY6ODKjV47q0qZH8Od42jePCVz7O0s
         3ihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HcpM41K3Tg/Gq2Sy2fOw39ukTQf5X/VzmfsS+yU67xU=;
        b=W3indvzyLgdKhb5Ne6YKmSXhZdS+FYWsk/mDFd5t3vlVAMfqVsftM2wwqPAYxXKhAt
         1DoBHVCQNV2Nxo+NcUZd1rWyKt7Cd5LHfQw0ZW10F4StJPyuAXRVTb3XHQQTsdSyBGHD
         P6Tjuein4heQhSEX3I86ncA8R7yMPCJBH6Hrn3gZVvIDPSJMzVYa1iVvtNTTWfO+mhuW
         WCd+3r9+pP5tysgKAG/NcMhzS43/1r5/sfioQp3MCvFB9MhZW/takRq3iz97PVJDr2c2
         LzSShbaYIgYE3akkJLwFM6scZ5mRompFvYX/Qf9MkOLa8pKhH3lsyjsd/WiIZ1UJDvcS
         EwGg==
X-Gm-Message-State: AFqh2kocp8Nv8fkyP4nFAhsUmoFVH8W9Xj41gGor65OJniTp2dZS9G/u
        Blt3M4V6vMo3JUGxjH2+RJccG9n9X4WAYi7C/Gk=
X-Google-Smtp-Source: AMrXdXutj5CXRYxZVz1GE2BcugsOWq5HiRWmZepwLQ+buZ49i5JcEFxYxazuCp1lN8B6N2AquQdaKFjZl2R0jiZqGNU=
X-Received: by 2002:a05:6402:1614:b0:492:7e5f:2b59 with SMTP id
 f20-20020a056402161400b004927e5f2b59mr1165239edv.414.1673177398844; Sun, 08
 Jan 2023 03:29:58 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:eca7:b0:7c0:dfb2:c37b with HTTP; Sun, 8 Jan 2023
 03:29:58 -0800 (PST)
Reply-To: muhammadabdulrahma999@gmail.com
From:   muhammad <nnannacollins2019@gmail.com>
Date:   Sun, 8 Jan 2023 03:29:58 -0800
Message-ID: <CAPQqOC2UtyuwO9Yiww_0mKLH0x1zZsfAsvJyhsRFqDWmwN2eWw@mail.gmail.com>
Subject: Re:Re:Inquiry about your products.!!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.8 required=5.0 tests=BAYES_50,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:543 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [nnannacollins2019[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [nnannacollins2019[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [muhammadabdulrahma999[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  2.0 DEAR_SOMETHING BODY: Contains 'Dear (something)'
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Dear Sir/Madam,

An open Tender for the supply of your company products to (Doha,
Qatar). Urgently furnish us in full details about the standard of your
product. We will appreciate it more if you give us with Details:
Specification and Catalogs or Price list via Email.To avoid making a
wrong choice of products before placing an order for it.

Terms of payment:An upfront payment of 80% (T/T) will be made to your
account for production,While 20% will be paid before shipment.

Thanks and Regards
