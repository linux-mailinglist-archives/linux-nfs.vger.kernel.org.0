Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 168037B557
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jul 2019 23:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387908AbfG3V4z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Jul 2019 17:56:55 -0400
Received: from fieldses.org ([173.255.197.46]:41854 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387630AbfG3V4z (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 30 Jul 2019 17:56:55 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id C275BABE; Tue, 30 Jul 2019 17:56:54 -0400 (EDT)
Date:   Tue, 30 Jul 2019 17:56:54 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] nfsd: add principal to the data being tracked by
 nfsdcld
Message-ID: <20190730215654.GC3544@fieldses.org>
References: <20190730210847.9804-1-smayhew@redhat.com>
 <20190730215428.GB3544@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730215428.GB3544@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 30, 2019 at 05:54:28PM -0400, J. Bruce Fields wrote:
> How does it fail when principals are longer?  Does it error out, or
> treat two principals as equal if they agree in the first 1024 bytes?

I guess it's being compared against a string passed from gss-proxy?  We
could also check for limits there.

--b.
