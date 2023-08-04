Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41876770BD9
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Aug 2023 00:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjHDWTG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Aug 2023 18:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjHDWTF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Aug 2023 18:19:05 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87239E70
        for <linux-nfs@vger.kernel.org>; Fri,  4 Aug 2023 15:19:04 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686bc261111so1976873b3a.3
        for <linux-nfs@vger.kernel.org>; Fri, 04 Aug 2023 15:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691187544; x=1691792344;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oit+ObbRG5ZwmJAT1Dmx/a9mCF676UB8oVqmA30SIro=;
        b=PGZk+e1X/KMJ0bHL7UkipXIEAj7zUeAyQRvpIlCSwmK3sWHvda/DFOslqlTailphyx
         nLgGZ0N5QD4eXccVLyGzEWtLPckEbHK2bn24ELSi9sWXoWhx80m7v7mOuKcHjZcKhgIC
         EVkXwXTSBXCPWIx9fBsshe5Y9XybKds3mp+Cn5z2L5PaA8fUajyQt1BCoOThpODPGpml
         hBD9gr3QpjJHU6aNKSv59ZN051r73mxsKAx45O1dO3QFxaZjYU0e5ljCVc78YEkatiof
         hXKgIHWJtmOi9iMcEtIXOBiE/FHWYj/d+1F5zoqOb4wl5Tm4ZNB7gqiP3Fb90V3tCNoi
         6W4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691187544; x=1691792344;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oit+ObbRG5ZwmJAT1Dmx/a9mCF676UB8oVqmA30SIro=;
        b=fQAvIBMZPYVfXF6HytKyft/HwMB6p4n0JTagQAx2XBQsLiYHnhZrE5M++52/MhZJJD
         oyJW0byC4qjUzRtOLkScy9kFnZDW0YEEGV98CmFCk4Q8TH5qqWKCKhYYPcWs+DHEK77N
         rY10/0eDreziYL9VSOmIW9pcpiiu7nhAXjNl0jRDi+3et4m5HQNU/pyiDNfErQOaG+qe
         A3JnMirpeRnf0Iw5MYOyp98i6efloVxkCYyJf7aHqydDV2ze8pWAwQ89ha1lenwLHiTH
         ZeJaZwAjR2lrSgUy/3ZphuDn0fSvBg0Y2eKdvUM6hIBTrYhPeDPzhB6z1pNSX5eayIBj
         hzHw==
X-Gm-Message-State: AOJu0YwA1TP18MQUc7989wOQTy4kuk7w4iSfji4oZrlTXd6m+kUIp+Sf
        +pwWNAEc5nBv0g6fZR2+TTTaDIDJRfELmXbM+xAT3aaLdA==
X-Google-Smtp-Source: AGHT+IGIwDoChT4K6l1jZpm81dGMTJwswnuOIlWQfPPqx5RGSE21cCl5sdBcmaJCtkFQotXOjlPMjhW/y2/KweB8L1Q=
X-Received: by 2002:a17:90a:53c5:b0:263:9e9b:5586 with SMTP id
 y63-20020a17090a53c500b002639e9b5586mr2468002pjh.44.1691187543951; Fri, 04
 Aug 2023 15:19:03 -0700 (PDT)
MIME-Version: 1.0
From:   Rick Macklem <rick.macklem@gmail.com>
Date:   Fri, 4 Aug 2023 15:18:52 -0700
Message-ID: <CAM5tNy4d02dOyWsVk7Y-nFEyGjE=eo4nJgrap3M5DebDJz9ehw@mail.gmail.com>
Subject: RFC: new attributes
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     David Noveck <davenoveck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I wrote an IETF draft proposing a few new attributes for NFSv4.2.
Since there did not seem to be interest in them, I just
let the draft expire.  However, David Noveck pinged
me w.r.t. it, so I thought I'd ask here about it.

All the attributes are meant to be "read only, per server file system":
supported_ops - A bitmap of the operations supported.
     The motivation was that NFS4ERR_NOTSUPP is supposed to
      be "per server", although the rumour was that the Linux knfsd
      uses it "per server file system".
dir_cookie_rising - Only useful for directory delegations, which no
      one seems to be implementing.
seek_granularity - The smallest size of unallocated region reported
      be the Seek operation.  FreeBSD has a pathconf(2) variable called
      _PC_MIN_HOLE_SIZE that an application can use to decide if
      lseek(SEEK_DATA/SEEK_HOLE) is useful.
mandatory_br_locks - Byte range locks are mandatory.  No one
      seems to be implementing these, but a client needs to know
      that mandatory locking is being enforced so that it can cache
      data correctly.
max_xattr_len - Allows the client to avoid attempting to Setxattr an
     attribute that is larger than the server file system supports.

So, does the Linux folk think any of these are useful enough to implement?
If not, I do not see any reason to pursue this further.

Thanks for any comments, rick
