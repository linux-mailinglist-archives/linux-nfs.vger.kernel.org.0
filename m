Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D1C29BDA2
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Oct 2020 17:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1811889AbgJ0Qn0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Oct 2020 12:43:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39025 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1811887AbgJ0QnU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 27 Oct 2020 12:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603816998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=mj6uaiHROCag3uZJ/gHJroorYDnXKuN4EyYRFIYPu8Y=;
        b=SbUT6LrPKSG/kjhEPSpbNL37X7EqS95pLWLFJN05U8T6IvmsgoI1621azrkHaUCQe2IU+4
        A+8ip+R7TFhvfL2PFtA2YPAVSij+jMd+5zp3Ro8XdkS11BXJM1Rlv3U/dAVL3h95weU9IY
        Ml5NELPo7a9T9EfhM60DKYJDO3/RVn0=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-pwuN7ChKN2uSNgqqxehNkQ-1; Tue, 27 Oct 2020 12:43:14 -0400
X-MC-Unique: pwuN7ChKN2uSNgqqxehNkQ-1
Received: by mail-oo1-f72.google.com with SMTP id t19so1012177ook.18
        for <linux-nfs@vger.kernel.org>; Tue, 27 Oct 2020 09:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mj6uaiHROCag3uZJ/gHJroorYDnXKuN4EyYRFIYPu8Y=;
        b=nOXBxCw8eVcAPAVznNgvP55uPwqRjSRtsf0vyKKFDz4S3pFz7ZYGvn+0jqCFqyV4sF
         z0E7pbXeU8EqVgWfySPUH0gNA8prYb4u0ROggw80Z0YEpR01WrfJs6F0DhF6NNjIc6JE
         6UYjJP3CWok8N0xBt0qgqG6nbk9QrNC5586Z2DbOYNWSm9vRZFzS5zuY2X2n2SvGtO5F
         Nb012bkXMZ4buhr/ZmDgIwW0vTkBz0hsy91WCyb45w/vuh4sB5tE9h+rrKaIEnSAaxD3
         OEhSEbRtU2yHE7mMWmpB+q+wVzdIRGL4YhRb+z1fbeqrbrguP6Deq3KMVv9oQZPljjLP
         H6cw==
X-Gm-Message-State: AOAM530jQ9i70j40pr4B6zbAd3luDoc8Url9m1GZPYm1IoUiflFRODM/
        Vv1VVQYtPviyufDOd0tWvHkGB39jkq2So3axktdSv4uh5rpjn4fDdugnudRJOM5cSRb54VMmvB5
        ghZ6eQGJE/tacLBNI/Qb2
X-Received: by 2002:aca:ef03:: with SMTP id n3mr2048471oih.67.1603816993832;
        Tue, 27 Oct 2020 09:43:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7y1eCX7WfRNi9tkZnfLpiDio1qtG9FKTpwYlLMD9SlPYp6FIE57BquNUx5oTk2cs+UUc+WA==
X-Received: by 2002:aca:ef03:: with SMTP id n3mr2048435oih.67.1603816993577;
        Tue, 27 Oct 2020 09:43:13 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l89sm90968otc.6.2020.10.27.09.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 09:43:12 -0700 (PDT)
From:   trix@redhat.com
To:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Cc:     linux-pm@vger.kernel.org, linux-crypto@vger.kernel.org,
        qat-linux@intel.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-iio@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
        netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-rtc@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, alsa-devel@alsa-project.org,
        linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        =?UTF-8?q?=EF=BB=BFFrom=20=3A=20Tom=20Rix?= <trix@redhat.com>
Subject: Subject: [RFC] clang tooling cleanups
Date:   Tue, 27 Oct 2020 09:42:55 -0700
Message-Id: <20201027164255.1573301-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This rfc will describe
An upcoming treewide cleanup.
How clang tooling was used to programatically do the clean up.
Solicit opinions on how to generally use clang tooling.

The clang warning -Wextra-semi-stmt produces about 10k warnings.
Reviewing these, a subset of semicolon after a switch looks safe to
fix all the time.  An example problem

void foo(int a) {
     switch(a) {
     	       case 1:
	       ...
     }; <--- extra semicolon
}

Treewide, there are about 100 problems in 50 files for x86_64 allyesconfig.
These fixes will be the upcoming cleanup.

clang already supports fixing this problem. Add to your command line

  clang -c -Wextra-semi-stmt -Xclang -fixit foo.c

  foo.c:8:3: warning: empty expression statement has no effect;
    remove unnecessary ';' to silence this warning [-Wextra-semi-stmt]
        };
         ^
  foo.c:8:3: note: FIX-IT applied suggested code changes
  1 warning generated.

The big problem is using this treewide is it will fix all 10k problems.
10k changes to analyze and upstream is not practical.

Another problem is the generic fixer only removes the semicolon.
So empty lines with some tabs need to be manually cleaned.

What is needed is a more precise fixer.

Enter clang-tidy.
https://clang.llvm.org/extra/clang-tidy/

Already part of the static checker infrastructure, invoke on the clang
build with
  make clang-tidy

It is only a matter of coding up a specific checker for the cleanup.
Upstream this is review is happening here
https://reviews.llvm.org/D90180

The development of a checker/fixer is
Start with a reproducer

void foo (int a) {
  switch (a) {};
}

Generate the abstract syntax tree (AST)

  clang -Xclang -ast-dump foo.c

`-FunctionDecl 
  |-ParmVarDecl 
  `-CompoundStmt 
    |-SwitchStmt 
    | |-ImplicitCastExpr
    | | `-DeclRefExpr
    | `-CompoundStmt
    `-NullStmt

Write a matcher to get you most of the way

void SwitchSemiCheck::registerMatchers(MatchFinder *Finder) {
  Finder->addMatcher(
      compoundStmt(has(switchStmt().bind("switch"))).bind("comp"), this);
}

The 'bind' method is important, it allows a string to be associated
with a node in the AST.  In this case these are

`-FunctionDecl 
  |-ParmVarDecl 
  `-CompoundStmt <-------- comp
    |-SwitchStmt <-------- switch
    | |-ImplicitCastExpr
    | | `-DeclRefExpr
    | `-CompoundStmt
    `-NullStmt

When a match is made the 'check' method will be called.

  void SwitchSemiCheck::check(const MatchFinder::MatchResult &Result) {
    auto *C = Result.Nodes.getNodeAs<CompoundStmt>("comp");
    auto *S = Result.Nodes.getNodeAs<SwitchStmt>("switch");

This is where the string in the bind calls are changed to nodes

`-FunctionDecl 
  |-ParmVarDecl 
  `-CompoundStmt <-------- comp, C
    |-SwitchStmt <-------- switch, S
    | |-ImplicitCastExpr
    | | `-DeclRefExpr
    | `-CompoundStmt
    `-NullStmt <---------- looking for N

And then more logic to find the NullStmt

  auto Current = C->body_begin();
  auto Next = Current;
  Next++;
  while (Next != C->body_end()) {
    if (*Current == S) {
      if (const auto *N = dyn_cast<NullStmt>(*Next)) {

When it is found, a warning is printed and a FixItHint is proposed.

  auto H = FixItHint::CreateReplacement(
    SourceRange(S->getBody()->getEndLoc(), N->getSemiLoc()), "}");
  diag(N->getSemiLoc(), "unneeded semicolon") << H;

This fixit replaces from the end of switch to the semicolon with a
'}'.  Because the end of the switch is '}' this has the effect of
removing all the whitespace as well as the semicolon.

Because of the checker's placement in clang-tidy existing linuxkernel
checkers, all that was needed to fix the tree was to add a '-fix'to the
build's clang-tidy call.

I am looking for opinions on what we want to do specifically with
cleanups and generally about other source-to-source programmatic
changes to the code base.

For cleanups, I think we need a new toplevel target

clang-tidy-fix

And an explicit list of fixers that have a very high (100%?) fix rate.

Ideally a bot should make the changes, but a bot could also nag folks.
Is there interest in a bot making the changes? Does one already exist?

The general source-to-source is a bit blue sky.  Ex/ could automagicly
refactor api, outline similar cut-n-pasted functions etc. Anything on
someone's wishlist you want to try out ?

Signed-off-by: Tom Rix <trix@redhat.com>

