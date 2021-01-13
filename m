Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36D02F463E
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jan 2021 09:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbhAMIPA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jan 2021 03:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbhAMIPA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jan 2021 03:15:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1143EC061786
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jan 2021 00:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gGDAxpRzDfTRkcbZGlaFNZEk3KKCV1HZKce10YnZBmg=; b=VoiXeG9Ix3ixAVkOCp31gYMPkJ
        jnYrjllWSoK2YQg/fkg1yIHvq4gJyHEnWQc2DXnUwqnDWx8PV6wjYMdqSR2LNpZyPxMiPVrPZJrpt
        Za7EKE+UQFbCbWDQ+ME/pnpNVD79bXOO9z4QqOTFbyU8wcIb5pSqYvltUbmgGvtbasWgQHJ8WVJG+
        gDlRu113P+0VEqYvj/e0NEKN9O1q5QsIdHfQW4qkp0I8ns810fwrCwTX3zknAReDfvxxo7GftWbdm
        jS4PpJ7/0UMeEZEc7BPoNVSZnOA14vVkww+Xh11Af6dqNbVXECCFnnOyC3s+CNyQtxEYGAbCUt/+T
        kDa97oAQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kzbGg-00601Q-31; Wed, 13 Jan 2021 08:12:50 +0000
Date:   Wed, 13 Jan 2021 08:12:38 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     "bfields@fieldses.org" <bfields@fieldses.org>
Cc:     Patrick Goetz <pgoetz@math.utexas.edu>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "wangzhibei1999@gmail.com" <wangzhibei1999@gmail.com>,
        "security@kernel.org" <security@kernel.org>, "w@1wt.eu" <w@1wt.eu>,
        "greg@kroah.com" <greg@kroah.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>
Subject: Re: nfsd vurlerability submit
Message-ID: <20210113081238.GA1428651@infradead.org>
References: <20210108152607.GA950@1wt.eu>
 <20210108153237.GB4183@fieldses.org>
 <20210108154230.GB950@1wt.eu>
 <20210111193655.GC2600@fieldses.org>
 <CAHxDmpR1zG25ADfK2jat4VKGbAOCg6YM_0WA+a_jQE82hbnMjA@mail.gmail.com>
 <CAHxDmpRfmVukMR_yF4coioiuzrsp72zBraHWZ8gaMydUuLwKFg@mail.gmail.com>
 <20210112153208.GF9248@fieldses.org>
 <8296b696a7fa5591ad3fbb05bfcf6bdf6175cc38.camel@hammerspace.com>
 <42fcbc42-f1b3-5d99-c507-e1b579f5a37a@math.utexas.edu>
 <20210112180326.GI9248@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112180326.GI9248@fieldses.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

FYI, if people really want to use some sort of subtree exports, for XFS
(and probably ext4) we encode the project id into the file handle and
use the hierarchical project ID inheritance that we already use for
project quotas.
