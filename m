Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EA956884D
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 14:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbiGFM2Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 08:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbiGFM2Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 08:28:24 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C9C1C9
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 05:28:22 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a5so7152187wrx.12
        for <linux-nfs@vger.kernel.org>; Wed, 06 Jul 2022 05:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=6yBY8MSRvJkhZO5OtD8CZMGiFwXE/ghx/D+Sy5Xc/H4=;
        b=n2rppUIA3jeoLNLTdo0fuUueadQa28Oj6GYSKOF10r9uVTCKsP3PkdMRMnB9UJLRFy
         5PFRr/ciK41KW83nNj+fHxKBJCmeGaabiTStk+i9ZbtX6wYjGv/mVNRgBUHn2HRh//LC
         7XF5DWZYkBS7QUECdsavIPLResh2TIXetbU0UcjwFE1hGMdIL5Ra+DQcyyckKALe8UXD
         8GbcG6NADAt5p6eM034/Tyt0+2i+B6WURepvolLz0zO7L+opiG8/8IMRcFGLJjSk/06U
         DeR5toB8WckzUgFDZsoVVJK8LAsBQZ5woDYBxvv+djBSDtBtsZCcqWkVYWhMHEu6WHSm
         l2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=6yBY8MSRvJkhZO5OtD8CZMGiFwXE/ghx/D+Sy5Xc/H4=;
        b=5nm2w4T/lhSuVfWeGauWUKICDZ2rn3l5PUG4j1RXd23lL4FpVkEXqXUEtKFFpLozoZ
         3gsE/G0LtgGJhlbiAmW4/8mpEEaRJ7Xouw/PDjfp+DdwmtCJzA0g84qD+YpOChX6yB40
         oXog+qFwREPkeTs8OB0bLrh0Cq4zbjkAYl4PrSx0NUxZVFNlFA+aw2FojD+J7t5vw9gh
         0435kQVxOJYjtXXh6yzTW0MajfY34UOOdGCwpoFvfbDytRIRAMb2VM7vn25DTZ/Q4Cno
         jWdIaHP2XOIOvVJ7gV48Kg2bOxcA2nDbdaDjJvUP3F/1616XJZ56rlzIStQ1hLb18wTP
         M2Jw==
X-Gm-Message-State: AJIora+nN41zo5CoIQjKZ9+IShW1pw070Mvip+gCPTSANup1QPmOcYqT
        7uhXPWclKbcTK4Y8B/lc4vmko2GBaGTpnzdfwii17oOczaM=
X-Google-Smtp-Source: AGRyM1uRHHgRq+UQ58678gjgDUMthmzshttP4/GLL67zoNfg8WZtkRJ2XRGntU6mUDNM2tpip/zrn4QTAFWr0Ty9SyI=
X-Received: by 2002:a05:6000:a12:b0:21b:93b9:134f with SMTP id
 co18-20020a0560000a1200b0021b93b9134fmr37520280wrb.310.1657110501011; Wed, 06
 Jul 2022 05:28:21 -0700 (PDT)
MIME-Version: 1.0
From:   jie wang <yjxxtd12@gmail.com>
Date:   Wed, 6 Jul 2022 20:28:09 +0800
Message-ID: <CACt_J9PHSjkz_-x0K=7+AYjiX1Ur5cV+brC9Tv4i7dkG=NSBuQ@mail.gmail.com>
Subject: Question abount sm-notify when use NFSv3 lock
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi, all
  When we use NFSv3, we have a LoadBalance in front of NFS server. For
example, LoadBalance's ip is ip2 and NFS server's ip is ip1, and
client use ip2 to mount.

  Now client use flock to lock file, then I restart NFS server and
execute sm-notify -f. Then the problem occurs, the sm-notify request's
src ip is ip1, not ip2, so rpc.statd will ignore this notify, because
it does not match ip2 when mount, so client will not reclaim lock, and
lock lost when restart NFS server.

  Do you know how to address this ? Thanks a lot.
