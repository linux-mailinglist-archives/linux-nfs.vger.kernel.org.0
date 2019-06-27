Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6046C5857A
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jun 2019 17:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfF0PXu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jun 2019 11:23:50 -0400
Received: from fieldses.org ([173.255.197.46]:36210 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfF0PXu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 27 Jun 2019 11:23:50 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 2F382C56; Thu, 27 Jun 2019 11:23:50 -0400 (EDT)
Date:   Thu, 27 Jun 2019 11:23:50 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 08/16] nfsd: escape high characters in binary data
Message-ID: <20190627152350.GA16539@fieldses.org>
References: <1561042275-12723-1-git-send-email-bfields@redhat.com>
 <1561042275-12723-9-git-send-email-bfields@redhat.com>
 <20190621174544.GC25590@fieldses.org>
 <201906211431.E6552108@keescook>
 <20190622190058.GD5343@fieldses.org>
 <201906221320.5BFC134713@keescook>
 <20190624210512.GA20331@fieldses.org>
 <20190626162149.GB4144@fieldses.org>
 <201906262100.00C1C22@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201906262100.00C1C22@keescook>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Jun 26, 2019 at 09:16:44PM -0700, Kees Cook wrote:
> Right -- any they're almost all logged surrounded by ' or " which means
> those would need to be escaped as well. The prism2 is leaking newlines
> too, as well as the thunderbolt sysfs printing.
> 
> So... seems like we should fix this. :P
...
> I think we need to make the default produce "loggable" output.
> non-ascii, non-printables, \, ', and " need to be escaped. Maybe " "
> too?

OK, so I think the first step is to take a closer look at the users of
the default %*pE.  If there are any that look like they'd be broken by a
change, we should make patches moving to something else, then we can
change the default.

Then we can also replace ESCAPE_ANY and ESCAPE_NP--that "don't escape
printable" logic is confusing and makes it hard to add more types of
escaping.  And it appears to only be used by %*pE.

--b
