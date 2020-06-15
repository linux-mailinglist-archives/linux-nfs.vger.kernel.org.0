Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A8C1F95AE
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2020 13:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbgFOLzT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Jun 2020 07:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729653AbgFOLzT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Jun 2020 07:55:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925B1C061A0E
        for <linux-nfs@vger.kernel.org>; Mon, 15 Jun 2020 04:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kZMaZTaUTmLyT0xUFe5L3jE78Fs0fXSrK/M6Vbj76Qk=; b=FJgMJuU54QP8l4zauFvaHOQ/QB
        XtzZwMjerO1nOoUeUbn8qijz8DXk/kXugHwl7t19RzkyowwzybUHHZWgX2uDH7mcZH2EVRMzbMUbO
        L22qx+56qEun+T6z5VXTs3336gna2LKg83Dmpo/WDn003LF93CTDgiP/4ufb1ZjDFsWmquUhFVFy4
        zEVhKHJWYyNpNb2s8IQEAi6vbpr9QB3uQ8Ex7GgfAatOe+rfqpQAZdMPYThS9qznrKVnel9mpsUZD
        iwjz3ZoGPQMAAnagDqteV0xTHr/BA4OA1jgW9XYO//NKuLDL0txVERgXf+CChrw3z5Vb/ef/P4ya0
        n573u7KQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jknhi-0002zv-7Z; Mon, 15 Jun 2020 11:55:06 +0000
Date:   Mon, 15 Jun 2020 04:55:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     Elliott Mitchell <ehem+debian@m5p.com>, 962254@bugs.debian.org,
        linux-nfs@vger.kernel.org, bfields@redhat.com, agruenba@redhat.com
Subject: Re: Umask ignored when mounting NFSv4.2 share of an exported ZFS
 (with acltype=off) (was: Re: Bug#962254: NFS(v4) broken at 4.19.118-2)
Message-ID: <20200615115506.GA7276@infradead.org>
References: <20200605051607.GA34405@mattapan.m5p.com>
 <20200605064426.GA1538868@eldamar.local>
 <20200605051607.GA34405@mattapan.m5p.com>
 <20200605174349.GA40135@mattapan.m5p.com>
 <20200605183631.GA1720057@eldamar.local>
 <20200611223711.GA37917@mattapan.m5p.com>
 <20200613125431.GA349352@eldamar.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613125431.GA349352@eldamar.local>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If you are violating our license please also don't spam our list when
using your crappy combination.
