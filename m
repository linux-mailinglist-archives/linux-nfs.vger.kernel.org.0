Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBCF525064
	for <lists+linux-nfs@lfdr.de>; Thu, 12 May 2022 16:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347565AbiELOkr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 May 2022 10:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355488AbiELOkp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 May 2022 10:40:45 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72BA23BCD
        for <linux-nfs@vger.kernel.org>; Thu, 12 May 2022 07:40:43 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p10so9428985lfa.12
        for <linux-nfs@vger.kernel.org>; Thu, 12 May 2022 07:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=r1ZFTWGT09A8oFFu73SVycnNExoa6XloWAbx7J+Xiio=;
        b=iSA1OpXpphIJC9bpEK4kSouyDzA7jvSrmDr3Nt4vIeC+bpO2YpGYg+CF7fG6TfPL0A
         Vuvn+Lf5fK2Q+xsOb1ZmEwdomb61w3slOQAq6MJl4FfQPh9TgWuRZSNOdTDyDs13zRal
         hyyYMn+K/vuZ+DcXgEovEVm/wFkXLsTR8ThRdr1Ev3kz6XxqYv/UoLH7eZccV4fQUcnz
         /+zA1KMyzt1VYxKkZvkaLf840PwGX0Qbi+5jeTkYCci8hoNKUemPPp3NTyITNpg7h1rg
         pfAErvYMFvZBWKnw3TZBoUkKRaJv3X/cqhEkAiAJ7JsELc+gvqf0ismFTxSYwVfx7ATQ
         5UWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=r1ZFTWGT09A8oFFu73SVycnNExoa6XloWAbx7J+Xiio=;
        b=NNcIBCnWCPnnEedJkg2zb4xDqqjcI+iidj0U1TPcktlxbP78aUxu95lsmeYayn8Jpl
         A4+ZxDyNws63Bcq/HVBa/55peDIF29dBx6Ktmo7XVu2UJBI/zRGTY9872Z83+P4wXce6
         usTyMnP4ujON+FICjvqt9/QG1UoSROyMcMtkAnbobc0O9laUL6kDo/s1kOIesYb5AtDM
         ndA0hM9omrFNd2sBQ3pF92EWzt/haf91pBElpBDdGIEUJgfFuxh/gvsteR0nGgaTe9kS
         bfO93RrjEVbOnZS6Vv0AhdGW3S/UtTGdD06Jqc+p65xyHoIcg0dddq8uZaLkcBd0/7Te
         BUKQ==
X-Gm-Message-State: AOAM533NotQ3sBFkZeXRuEsmDtDU7Ws65ywwCJFRpFXmE7GgFq1+ErPD
        qmul316+QE2Sayf9SgwsOhO5+moemO0r9EhjoKWgw7q0ciQ=
X-Google-Smtp-Source: ABdhPJwnS76ig8mWLfCVrLiupseKshUoe5bjKmBfAFYBP/3RMaelslrhmfcbX/l2ObXuSt1+8xsMg6tduhV+FOv/9qY=
X-Received: by 2002:a05:6512:baa:b0:472:5ec9:f625 with SMTP id
 b42-20020a0565120baa00b004725ec9f625mr82133lfv.560.1652366441827; Thu, 12 May
 2022 07:40:41 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Chilvers <chilversc@gmail.com>
Date:   Thu, 12 May 2022 15:40:31 +0100
Message-ID: <CAAmbk-cVYfEig+HG6H7apcF==H0g4pwSXfEAGHw4JcjSGkddHA@mail.gmail.com>
Subject: Calculating total server read/write bytes
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I want to display the total server read, and server write bytes from the
io_stats. However, this poses a challenge as the only way I can find to retrieve
these stats is from /proc/self/mountstats.

The issue I run into is that io_stats is per nfs_server record, while the output
is reported per mount. Multiple mounts can share the same nfs_server record.

This means while parsing the mountstats I need a way to reliably determine if
two mounts share the same nfs_server record.

From reading the source it appears that nfs_server and super_block are
correlated 1:1, and s_dev for NFS is allocated a unique value via
set_anon_super.

My plan is to run stat on the mount point to fetch the st_dev value. Thus is it
safe to assume (for NFS) if two mount points have the same st_dev value they
share the same io_stats, and if the st_dev value is different they have separate
io_stats, or is there some scenario that I've missed?

Longer term it would be nice to make this process simpler, I can see several
options on how to handle this:

1. Add a unique identifier in the mountstats (e.g. s_dev) that can be used as a
   unique key.

   The concept here is that anything scraping the stats does not need to
   rely on the assumption that io_stats has a 1:1 correlation with super_block
   or that s_dev is unique. If the implementation were to change in future the
   key can be updated to match.

   The only issue is if this uses an existing value such as s_dev consumers
   might ignore the fact that the key should be treated as an opaque value and
   only used to deduplicate io_stats and start relying on the key matching the
   s_dev value. As such it might be necessary to allocate
   a separate unique key to the io_stats.

2. Two separate files in procfs that only output each unique stat once.
   * io_stats for each nfs_server excluding xprt: lines (multiple nfs_server
     entries can share the same RPC transport).
   * stats for RPC transports (xprt lines). These should be unique so that each
     RPC connection is only displayed once.

3. Add a new file to procfs that outputs aggregated io_stats (including xprt
   lines). These stats should be aggregated at the source server level. It is
   still useful when a client has mounted exports from multiple servers to have
   separate stats per server.

--
Chris
