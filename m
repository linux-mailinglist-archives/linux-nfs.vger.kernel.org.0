Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1B67D7BA1
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2019 18:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbfJOQbl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Oct 2019 12:31:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56704 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388088AbfJOQbl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Oct 2019 12:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Bz/cXxqXDsLaxH2BJxIVTieueWes3JBGDg9wSSTND6k=; b=FxFTDNK/OR8UcgYmRhV7i2x70
        R7r2aOeXeTW5G6BofaO1VRoYa2hhEhB/VEunT2+i44XEtxfgj4GAPR9cXypmBgZpeSyDIjFCGpgSt
        ESBsOtwIAz55gXaEViAKbl5bOKDQB+aj8knVZuhvcT7MytY9SDniln2NFZaewLFvPKKaZn/LYEeNn
        3usCS/A6Ph29jOomZndcbmenJxv4sRW22Vp7JI79/RV8i1PLla+ooMtAN9ceh7xJo0tyMzdz5FMNa
        gj1afvXfi1oyJCVMfc2JCaTXXSgerrkfnH6+DyGpywJaJaqrkmocqZZ3xtHKf+cN7tskXuf5W9AEF
        qNmkDZqYA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKPjU-0000Pd-2H; Tue, 15 Oct 2019 16:31:36 +0000
Date:   Tue, 15 Oct 2019 09:31:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NFSv4: add declaration of current_stateid
Message-ID: <20191015163136.GA11160@infradead.org>
References: <20191015121953.14905-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015121953.14905-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Oct 15, 2019 at 01:19:53PM +0100, Ben Dooks wrote:
> The current_stateid is exported from nfs4state.c but not
> declared in any of the headers. Add to nfs4_fs.h to
> remove the following warning:

I think you also need to remove the extern in pnfs.c as well.

Also nfs4_stateid_is_current has a local variable with the same name,
so you might want to rename that so that we don't get symbol shadowing
warnings.
