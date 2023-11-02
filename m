Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9495F7DEDB0
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Nov 2023 08:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344042AbjKBHvb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Nov 2023 03:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344449AbjKBHvb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Nov 2023 03:51:31 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEDF128
        for <linux-nfs@vger.kernel.org>; Thu,  2 Nov 2023 00:51:24 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9db6cf8309cso65209666b.0
        for <linux-nfs@vger.kernel.org>; Thu, 02 Nov 2023 00:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698911483; x=1699516283; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kK27iD0504TSFCEw7zK3v4YbKXhTfAzhD46cIV4aUI0=;
        b=mFWKfPyKPEo1odfu8+pfX20ySijORg2Q0fkh4J5+gV6wQkh9reFLb6muWeCtfyiej2
         aSDtCpfCRsUAvTttEltFQolnuDrb+GzjVug8x4rX8ODo5eIGOnVG9aSRLuerO6AcmV6G
         chBlDbJtRa4nXz6GyC31MnFWLqhqozJsw+snIiZ2ywHCBHAlaRfgN1b42Lbue+v/+IhF
         s0Twsr609/Zl+sSS/c8CqB2rncUKDlcgq/yV6Jel+umiYwzslIL3P3sCEGVdljPiuAME
         NR+HRutrmXYbDPJjnshNld61D50I+3eBY7aFCV3qnechUJfQTmU8V0aIR4qsWNkflUTl
         uAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698911483; x=1699516283;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kK27iD0504TSFCEw7zK3v4YbKXhTfAzhD46cIV4aUI0=;
        b=BzRADFncT7WQ8YkTn8M7X/pemokkB08BB9eeI51BRqN5nkhKDyLKEdj91u2g3O2mwJ
         jgvf0aQm7rJN8T/Izs2Q+I6U272pzK2TnGnfu8yTWS25Dm5j80DUpXoeG8rTg3AdNPmO
         G4IFDMJ58t9+hJ3UvNxKpIhJ5uN/ZwtTapcSq0Z8F4kjAzdO+m93Z7Jgz5fASTwHq3DF
         etCtKIQov0qoyT7YKZUHRSF79ZkZuNEgcjw6MPsNoNReHG1CZn/ne/rZd1sjUdjnIktF
         wUEqVh8vLqbDewPo9zYlBnPIlhi1QpizhrpaumryYHCrRyL0dMYlSLQSaOJnE9bAd0Z8
         uEww==
X-Gm-Message-State: AOJu0Yw57SwRay0cVp0Oh1JVqDj4GPwlrdUZVkp5dZ5u2x2RXnRLovlX
        RhoVa80ZM98GeSydA6o7T4cCiA==
X-Google-Smtp-Source: AGHT+IGrXKmYmu7CN/Yk/E4yPiDCUbMNzHDYulVKHMaxEcs97WXRMP5F86Uy8JABL6mSfG9S/V2QTA==
X-Received: by 2002:a17:907:84c:b0:9d4:55b1:924e with SMTP id ww12-20020a170907084c00b009d455b1924emr3819622ejb.74.1698911483032;
        Thu, 02 Nov 2023 00:51:23 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j8-20020a170906278800b009be14e5cd54sm795453ejc.57.2023.11.02.00.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 00:51:22 -0700 (PDT)
Date:   Thu, 2 Nov 2023 10:51:19 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     kent.overstreet@gmail.com
Cc:     linux-nfs@vger.kernel.org
Subject: [bug report] bcachefs: Update export_operations for snapshots
Message-ID: <40509a12-fe60-4ba4-af51-ba11b522156f@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello Kent Overstreet,

The patch 85e95ca7cc48: "bcachefs: Update export_operations for
snapshots" from Nov 13, 2021 (linux-next), leads to the following
Smatch static checker warning:

	fs/exportfs/expfs.c:140 reconnect_one()
	warn: 'parent' can also be NULL

fs/exportfs/expfs.c
    121 static struct dentry *reconnect_one(struct vfsmount *mnt,
    122                 struct dentry *dentry, char *nbuf)
    123 {
    124         struct dentry *parent;
    125         struct dentry *tmp;
    126         int err;
    127 
    128         parent = ERR_PTR(-EACCES);
    129         inode_lock(dentry->d_inode);
    130         if (mnt->mnt_sb->s_export_op->get_parent)
    131                 parent = mnt->mnt_sb->s_export_op->get_parent(dentry);

Smatch is complaining that bch2_get_parent() returns NULL:

85e95ca7cc48c (Kent Overstreet  2021-11-13 19:49:14 -0500 1216)         if (!parent_inum.inum)
85e95ca7cc48c (Kent Overstreet  2021-11-13 19:49:14 -0500 1217)                 return NULL;

I think it should be an error pointer?

    132         inode_unlock(dentry->d_inode);
    133 
    134         if (IS_ERR(parent)) {
    135                 dprintk("get_parent of %lu failed, err %ld\n",
    136                         dentry->d_inode->i_ino, PTR_ERR(parent));
    137                 return parent;
    138         }
    139 
--> 140         dprintk("%s: find name of %lu in %lu\n", __func__,
    141                 dentry->d_inode->i_ino, parent->d_inode->i_ino);
                                                ^^^^^^^^

    142         err = exportfs_get_name(mnt, parent, nbuf, dentry);
    143         if (err == -ENOENT)
    144                 goto out_reconnected;
    145         if (err)

regards,
dan carpenter
