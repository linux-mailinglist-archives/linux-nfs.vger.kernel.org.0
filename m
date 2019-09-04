Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8DE7A9419
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Sep 2019 22:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbfIDUuQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Sep 2019 16:50:16 -0400
Received: from fieldses.org ([173.255.197.46]:55740 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728526AbfIDUuQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 4 Sep 2019 16:50:16 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id D613A1CB3; Wed,  4 Sep 2019 16:50:15 -0400 (EDT)
Date:   Wed, 4 Sep 2019 16:50:15 -0400
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     bfields@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v5 0/9] server-side support for "inter" SSC copy
Message-ID: <20190904205015.GD14319@fieldses.org>
References: <20190808201848.36640-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808201848.36640-1-olga.kornievskaia@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

What do we know about the status of NFSv4.2 and COPY support on Netapp
or other servers?  In either the single-server or inter-server cases?

--b.
