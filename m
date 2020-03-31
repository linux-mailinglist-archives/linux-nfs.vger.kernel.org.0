Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C460B19900D
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2020 11:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbgCaJIf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 31 Mar 2020 05:08:35 -0400
Received: from edge10s.ethz.ch ([82.130.75.187]:55707 "EHLO edge10s.ethz.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730990AbgCaJId (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 31 Mar 2020 05:08:33 -0400
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Mar 2020 05:08:32 EDT
Received: from osaka.inf.ethz.ch (129.132.10.50) by edge10s.ethz.ch
 (82.130.75.187) with Microsoft SMTP Server id 14.3.487.0; Tue, 31 Mar 2020
 11:02:21 +0200
Received: by osaka.inf.ethz.ch (Postfix, from userid 50515)     id 3FE62B7279;
 Tue, 31 Mar 2020 11:02:23 +0200 (CEST)
Date:   Tue, 31 Mar 2020 11:02:23 +0200
To:     <linux-nfs@vger.kernel.org>
Subject: [PATCH] Add regex plugin for nfsidmap
User-Agent: Heirloom mailx 12.5 7/5/10
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20200331090223.3FE62B7279@osaka.inf.ethz.ch>
From:   Stefan Walter <walteste@inf.ethz.ch>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


