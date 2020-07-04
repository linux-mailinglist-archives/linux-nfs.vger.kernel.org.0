Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCB221430B
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jul 2020 05:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgGDDVO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jul 2020 23:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgGDDVM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Jul 2020 23:21:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA84C061794;
        Fri,  3 Jul 2020 20:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2T86phqvAjaFev1DitRym/3ukUuz3anye73gz3G7R78=; b=cwGGq3XJv64zqNaxsegz15kH2d
        j3kiOnOl8Szg4QARRlvN0/pdBxzdH1lTGsw4F0NQ11c7yXqZt8rIiEfjXtC/fDkmLI/20jFkXT7ID
        DUtGIPblPYEFFm9m+A4WTJTPpylbXzLEmyFTkzIqwkHQQtmbume1OXesFufG+Ymkm38h1c+5bA6Ug
        ZzfoxpLBMeaa61dIOpPfywy+0IF6ZDQ34xj82KX0ghkxskMoIOyr/mrbwekCraXG8FHORusXTWjnr
        ucJRUrNj71DrU7aadinKacnN9B1lKeREJG8AUK95IEhA4rDpDeVYFVhfRErFf+W6n1UJS/1gtCpL2
        lMMbGdxw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrYjl-0000Ri-AL; Sat, 04 Jul 2020 03:21:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        cgroups@vger.kernel.org, dm-devel@redhat.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org
Subject: [PATCH 09/13] Documentation/admin-guide: intel_pstate: drop doubled word
Date:   Fri,  3 Jul 2020 20:20:16 -0700
Message-Id: <20200704032020.21923-10-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704032020.21923-1-rdunlap@infradead.org>
References: <20200704032020.21923-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Drop the doubled word "to".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
---
 Documentation/admin-guide/pm/intel_pstate.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/admin-guide/pm/intel_pstate.rst
+++ linux-next-20200701/Documentation/admin-guide/pm/intel_pstate.rst
@@ -708,7 +708,7 @@ core (for the policies with other scalin
 
 The ``ftrace`` interface can be used for low-level diagnostics of
 ``intel_pstate``.  For example, to check how often the function to set a
-P-state is called, the ``ftrace`` filter can be set to to
+P-state is called, the ``ftrace`` filter can be set to
 :c:func:`intel_pstate_set_pstate`::
 
  # cd /sys/kernel/debug/tracing/
