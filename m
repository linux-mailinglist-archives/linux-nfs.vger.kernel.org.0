Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630851BACF4
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2020 20:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgD0Sjl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Apr 2020 14:39:41 -0400
Received: from fieldses.org ([173.255.197.46]:36466 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgD0Sjl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 27 Apr 2020 14:39:41 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id EA0BE40B5; Mon, 27 Apr 2020 14:39:40 -0400 (EDT)
Date:   Mon, 27 Apr 2020 14:39:40 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     trondmy@kernel.org
Cc:     Steve Dickson <SteveD@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 6/7] mountd: Ignore transient and non-fatal filesystem
 errors in nfsd_fh()
Message-ID: <20200427183940.GF31277@fieldses.org>
References: <20200416221252.82102-1-trondmy@kernel.org>
 <20200416221252.82102-2-trondmy@kernel.org>
 <20200416221252.82102-3-trondmy@kernel.org>
 <20200416221252.82102-4-trondmy@kernel.org>
 <20200416221252.82102-5-trondmy@kernel.org>
 <20200416221252.82102-6-trondmy@kernel.org>
 <20200416221252.82102-7-trondmy@kernel.org>
 <20200427183844.GE31277@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427183844.GE31277@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ack to the series, otherwise, looks good.--b.
