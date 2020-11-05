Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012242A8785
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Nov 2020 20:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbgKETrz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Nov 2020 14:47:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKETrz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 5 Nov 2020 14:47:55 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14AEC0613CF
        for <linux-nfs@vger.kernel.org>; Thu,  5 Nov 2020 11:47:54 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id o9so4425469ejg.1
        for <linux-nfs@vger.kernel.org>; Thu, 05 Nov 2020 11:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=XFof7o1OM4kH7v1f5BsZDNPjpMLcZri8eUFtQtquN2w=;
        b=WUSWqu+jFp3ebv9fYd4CX24bZLGmu1sWr0cTwHSYfuv+OoYCL0oSVxcEh2dreRVRIJ
         TfjcJwuM1JGlzyIjh/sAO2CT7j7sC7uD4q3GYAQXwXOQyKv8mLQLhlqR+/uKiuiw4vLV
         WlEtT9d6P8ZRkPmW6LNs8xNxjfLG4Q6YaXG+X8ot8UM0XhfMcF0UmBslKDIO52prxJqm
         1mCqyzsSApIpd65ToOB1Py2K3gx7dyZ+WPkTH9Zt5Ub0r42vtDXSAC8b3T72wmLuhpeH
         rdlzQQD5zIAYz+nv+dZDWzZih2FkqRIvShynqzO8otEQ04rHIxrfLYEt7hRtGN/7u+Rm
         MlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XFof7o1OM4kH7v1f5BsZDNPjpMLcZri8eUFtQtquN2w=;
        b=LPcN3SEd3VtwuG/2YlT3Voo6sz1MtTHCFRMfo3RUqzK10NaIYbO8LfB6I7A69HFQQv
         9xzBdC9YeW1k5O+Swvp9E+2bk3ueahkGUwTWEZLNIb9qVzvevsFsDLSDH27FwBdzWY5X
         tS2i+vjq1a2/apr7F4fz4NR2heFHCc2HJwQT+anN3rVuYyC87OqO/+cJGAay+pkFs662
         /CRVfQE3i8csC2Te9gNfxA45YYdIb0Gu/8w2XL7ajOzFCCCZag4vB936YYNvv+Xm1a7P
         ZYuJDkndYv9fjjE0wTKNsMYhpvCZ+6U9hf+lwWJdhKxig7Hjl273pGtZXO2UC5PTAimx
         c12w==
X-Gm-Message-State: AOAM533tDJ+iSnJjd/f3ESNshyWfUFphNwP59n6uY2RmXOH1BcEtuORK
        OI5SRRmNGYilLG3DWetVbaP4C1AXe6Oehp0g74c=
X-Google-Smtp-Source: ABdhPJz93cZr2dB47s02Kuj1U9lyWAn1r351sTgkxWSHuc3c8BAro032udqNrXpY50piEeyjOcHIJvQjbZ54D0TrZjY=
X-Received: by 2002:a17:906:3899:: with SMTP id q25mr4176528ejd.0.1604605672322;
 Thu, 05 Nov 2020 11:47:52 -0800 (PST)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 5 Nov 2020 14:47:41 -0500
Message-ID: <CAN-5tyFAc0R=D0OL2WHkKacTMW0JxKmLoqv2A2Et2gg5G6gjtQ@mail.gmail.com>
Subject: question about labeled NFS+rfc7569+selinux
To:     NFSv4 <nfsv4@ietf.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>, earsh@netapp.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi folks,

I would like to know if somebody can comment on the following
regarding labeled NFS.

RFC 7569 talks about Label formats and specifically lists that "0" is
a reserved value.

Using labeled NFS with SElinux and looking at labels (in wireshark),
the selinux sends sends/sets label format as 0 (ie. this is a reserved
value according to the spec)

So we have labelformat_spec4 set to 0 where the spec says this field
"The LFS and the Security Label Format Selection Registry are
described in detail in [RFC7569]". It's unlikely that  "0" reserved
for Selinux and not explicitly specified there?

0 seems to be a good choice for using as a default label which the
RFC7862 vaguely talks about (though says nothing about the format for
a default label).

I'm not aware if Selinux is supposed to follow a spec and therefore I
don't think it is obligated to follow the rules of RFC 7569. Anybody
can comment how labeled NFS label format and SElinux label format
choice are supposed to co-exist?

Thank you.
