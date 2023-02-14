Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236BB69676E
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Feb 2023 15:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjBNOzn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Feb 2023 09:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbjBNOzm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Feb 2023 09:55:42 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE17435A7;
        Tue, 14 Feb 2023 06:55:41 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id o36so11176053wms.1;
        Tue, 14 Feb 2023 06:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QvW5pGHVivMxjs1aNmPctDUR2Ntx1Oph/YR4c4+1gmo=;
        b=oqoB0LXHb8Eh3I37klRsLyZehbOLG+pwWVZuRKb62bUdPDYp4W6DvOa5Zp0aRv/sAI
         AVLt9nMDbSCkzhT1vD0RgzUpOHTm2RDDiYFsO6L/2ia4tGf7y1fnDZHZhqVQgD7XRRlt
         vzFDxPyc7eRMAr6XKBCXgaOcu+HWhurOBbWX8BvQcoM2ZbuWtEwBV5sRsLdDwHn0OIW2
         EWll4UTJFG/y/W7y8fa5AIlJR/Zea0KyRjqNqw0qLgeCiJt/s5C7No46kINmRLOsyFT/
         WQTlydUZaZUwGu+ir6aRn9wKVQ3tIzNHPXwwFfonPMfzRZsMp22aIdN+HExyM7r9fier
         6xGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvW5pGHVivMxjs1aNmPctDUR2Ntx1Oph/YR4c4+1gmo=;
        b=svk6tiNBEKYN19yKIoy1KyyBjCxqKZ4jDZH2D8325Ay5M4BKH61wu3hq7O92WHl0fq
         DDIYgrbRSrgNftmrKRsdUXD1CLUjxfAjwgSOSj8vJahbzoJHB3XpAyCBzyK4Xx7MiPrA
         2oovS5FIsUja4XzMrz0Ect5cobZJNLlCcl78HRpjpg3tpBApS/dcqCDDFbeMviZRX63q
         jmBbcjJjcpoGEqyl9x2kiPCDU32/YVOmSxW3dlN2wgp+uLQw5frD148KeOPo5iFuI9rO
         osz9Ex+oaO3iDpY/6UeVlm0hOJFMjcWb+hAS6qx0kRI39217p5/nl9fZ4iXeOXwhpGMB
         YDNA==
X-Gm-Message-State: AO0yUKXQTgAzzjY7im81Cf+xObGy/+2gt+HtgQaYtil6cq89SaLMzRsn
        CNtLvCvn7F+h1eaCKLSsTHA=
X-Google-Smtp-Source: AK7set+kdPQihdChAfLBVJIbmsaK+sCKpNRiEaD0LnQChHH5Wm48eY1CvKWWpE3RF7KfpojCGaLgSg==
X-Received: by 2002:a05:600c:3caa:b0:3df:f85a:46fe with SMTP id bg42-20020a05600c3caa00b003dff85a46femr2175409wmb.40.1676386540332;
        Tue, 14 Feb 2023 06:55:40 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id r14-20020a05600c35ce00b003dc4ecfc4d7sm18823993wmq.29.2023.02.14.06.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 06:55:39 -0800 (PST)
Date:   Tue, 14 Feb 2023 17:55:35 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] nfsd: remove redundant assignment to pointer dentry
Message-ID: <Y+ug53kWXe5tqZbw@kadam>
References: <20230214141428.301121-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214141428.301121-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Feb 14, 2023 at 02:14:28PM +0000, Colin Ian King wrote:
> The pointer dentry is assigned a value that is never read, the
> assignment is redundant and can be removed.
> 
> Cleans up clang-scan warning:
> fs/nfsd/nfsctl.c:1231:2: warning: Value stored to 'dentry' is
> never read [deadcode.DeadStores]
>         dentry = ERR_PTR(ret);
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

No need to initalized "int ret = -ENOMEM;" either.

regards,
dan carpenter

