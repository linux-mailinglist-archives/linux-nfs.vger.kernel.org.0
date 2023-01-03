Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAB765BEDE
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Jan 2023 12:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbjACLZK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Jan 2023 06:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjACLZJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Jan 2023 06:25:09 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816B410BB
        for <linux-nfs@vger.kernel.org>; Tue,  3 Jan 2023 03:25:08 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id h185so4329634oif.5
        for <linux-nfs@vger.kernel.org>; Tue, 03 Jan 2023 03:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infinidat.com; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uoHYjpy0IWXiMTEHLVMUQG82fGkVHoK5AKHTyC4RtVI=;
        b=LffsAjTysNoaehuVYAfVxJZalHsjlSkHp8z9wQ75q6n/Yu338XeCSj+XfhIIBObA24
         NNo6lSo9jIeTzEXJaU5nDYnLCAPJwwU43QzhLULftS/2+fmE9ps/j/LRBuNGbcbjA5wi
         kLMcH56xShXqgG7GeKmZ5Z0i5ggugK0y7PsgFuuR68RJ+kHnVd2sxKLPccHPtxWdOFkb
         IYKTmF+q4rJWVFI6p0/uUzc5XGqkoNYw2BKT8nq0uYN8i8kA7VTcQ9bHmyepEkFSyvkZ
         2AQf80YLgzep+Oel3MtrFbgmHrWFmKVHlWSv4BAsqew+ndPRJre4wGo6orkQ2Qaf5XIb
         KE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uoHYjpy0IWXiMTEHLVMUQG82fGkVHoK5AKHTyC4RtVI=;
        b=0W6KAe/KVg7G35+EwPCt9E0hY6pSl+YzJMAUfWCD4TW0dVuj7DZ6fdTW4vQE1189a0
         TvBUfs2/wTu8F89Agnhmk09s8uyWfUC+hBUIzCypLSt5P29TN3YzTjau5JUpA37jr6hW
         1Aq1IxMSyxiSpylzqblZ8X04J65sxo6qLnlyIXNM572HirAPP9JfMPsXvTKKnaDmdwuZ
         CAljbQ/EKC6xGFahq2RD1yepofjWyPQBIWAalcyYPWvHnzwHiq66eyWEoJb+BflTCqZT
         68dqkU5dU5cNHl/S5LJvKlgptvwDChyBopzjoA7+E/dJALRW+K+4GH+s4OXPKOMPaoM4
         BJEw==
X-Gm-Message-State: AFqh2ko8yPfh2B6UnIvPas6+zf0NYJUuIYnMaDhQ6mKHHKWONEq6k12E
        FQw5y3l0VdjusOH4b/iooCTlmvuyJcN032WFkJN5GkjWRPrW5uiA
X-Google-Smtp-Source: AMrXdXtLxwXqQB0/5OsPfsV7X1pmDWUHU5uPSqeS5RHvC6h9MhdoIoqlI2hQ0opHAIg0ZhB757LrzLt7MF5yaKDmKGM=
X-Received: by 2002:a05:6808:190e:b0:35a:1bdf:3db1 with SMTP id
 bf14-20020a056808190e00b0035a1bdf3db1mr2108470oib.18.1672745107830; Tue, 03
 Jan 2023 03:25:07 -0800 (PST)
MIME-Version: 1.0
From:   Liad Oz <loz@infinidat.com>
Date:   Tue, 3 Jan 2023 13:24:42 +0200
Message-ID: <CAEdO7htksvMy7TBSLupmYbXqWf427y5byGyuXSW=APn2ZUCKYQ@mail.gmail.com>
Subject: Bundling pynfs as a python package
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In my company, we want to integrate pynfs as part of our python
testing environment. To do this, we need a package that can be
installed using pip. Currently, it is not possible to turn pynfs into
a pip-installable package due to the directory structure. I have been
working on a branch that introduces major changes that fix this issue
https://github.com/LiadOz/pynfs/pull/1/files.

With this new branch, to install the package you need to run pip
install . in the root directory. For a local installation, run pip
install -e . (which replaces the use_local modules). I have also
updated the README with these changes.

After installation, several scripts should be automatically added to
the path (which is why using a virtual environment is recommended):
nfs41server, nfs41testserver, nfs41testclient, nfs41proxy,
showresults. I have checked these scripts and they seem to work.

Please note that I have not finished making all the changes needed for
nfs4.0. I could take the time to complete these changes if you think
the bundle changes can be merged into master.
