Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27F55E0F46
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2019 02:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfJWAmV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Oct 2019 20:42:21 -0400
Received: from mails1n1-route0.email.arizona.edu ([128.196.130.51]:34758 "EHLO
        mails1n1-route0.email.arizona.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727403AbfJWAmV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Oct 2019 20:42:21 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Oct 2019 20:42:21 EDT
IronPort-SDR: 4a4ONMkdgp0TUJfwi45iMqfxU5HIFSFcsSuR8FdBF8Qizsw6hA+9eOYk7V1y9Lg6MAEdQ6jiZo
 DC3MnS+J9ybg==
IronPort-PHdr: =?us-ascii?q?9a23=3ACUmBgx/7zBM/Vf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B41+gcTK2v8tzYMVDF4r011RmVBN6du6IP0LGempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffgtFiCC+bL5xIxm7owvcvdQKjIV/Lao81g?=
 =?us-ascii?q?HHqWZSdeRMwmNoK1OTnxLi6cq14ZVu7Sdete8/+sBZSan1cLg2QrJeDDQ9Lm?=
 =?us-ascii?q?A6/9brugXZTQuO/XQTTGMbmQdVDgff7RH6WpDxsjbmtud4xSKXM9H6QawyVD?=
 =?us-ascii?q?+/6apgVR3mhzodNzMh7m/ZitF+gqFVrh2uuxNxzJXZYJ2XOfdkYq/RYc8WSG?=
 =?us-ascii?q?hHU81MVyJBGIS8b44XAucfPeZXtY/9qEYKrRSgHwmnGeTixSVViX/z3K061f?=
 =?us-ascii?q?8sEQ7Y0wwmGNIOtWrboM/vO6cIUOC0za7IzTPZYP9Mxzjy9ZXIfwknrPqRXr?=
 =?us-ascii?q?xwadLcxVQxGw7GlFmctIjoMjKP2ugQvGWW6/BsWfyghmMmrQx6vyKhyd02io?=
 =?us-ascii?q?bTg4IY0lXE9SJkz4krPdC4U0t7YcK8EJtXqiGaK5N6QsM8TGFsvyY30rkJtY?=
 =?us-ascii?q?OlcCUJ0pgr2hrSZv2df4SV7R/uUPydLSl3iX9kfr2znxey8U6+xe3gTsS4zU?=
 =?us-ascii?q?hGoylfntXRsn0A1gbf5tWIR/Z55EutxzmC2gHL5uFBO080lK7bK5A7wr43k5?=
 =?us-ascii?q?oeqV7METLzmEX3iq+bbUok9fau6+TgZ7XpuIWQOJVuigH/M6Uuncq/Dv4iPg?=
 =?us-ascii?q?cQQmeb5Pyw1Kf/8k3hXLVKkvo2n7HdsJDbI8Qbu6G4DxZT0oYt8BayFCmm0N?=
 =?us-ascii?q?sGknkdNl5FewyIj5LvO17QJPD0F/C/g06jkGQj+/eTOrznH4WIKHbYuKnucK?=
 =?us-ascii?q?w76ENGzgc3i9dF6MF6ELYEddnzU0n9sNHCRkswPwm1xc7oBdN6045YUHiOEK?=
 =?us-ascii?q?ifOeXfvULetbFnGPWFeIJA4GW1EPMi/fO71XI=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CIDQAMoK9d//aVxIBlhiEgEoRQiQK?=
 =?us-ascii?q?EeoYLAYEZileMMQEIAQEBDhMZAQIBAYgQOBMCAwkBAQEEAQEBAQEFAgIBbIR?=
 =?us-ascii?q?rK4JnIoMZFVkQDQImAoENgweCUyWyC4EyGoU0gnYfCYFVgQ4ojCd4gQeBOAy?=
 =?us-ascii?q?HTGOCQ4JeBIE3iF+MHUSWZx+CD4EYBV6TJQYbhD6JagOLI6glgWkigVhNJRO?=
 =?us-ascii?q?BWYFPT4J+AQEBjw8hgTYIARUIEgEKAY5bAQE?=
X-IPAS-Result: =?us-ascii?q?A2CIDQAMoK9d//aVxIBlhiEgEoRQiQKEeoYLAYEZileMM?=
 =?us-ascii?q?QEIAQEBDhMZAQIBAYgQOBMCAwkBAQEEAQEBAQEFAgIBbIRrK4JnIoMZFVkQD?=
 =?us-ascii?q?QImAoENgweCUyWyC4EyGoU0gnYfCYFVgQ4ojCd4gQeBOAyHTGOCQ4JeBIE3i?=
 =?us-ascii?q?F+MHUSWZx+CD4EYBV6TJQYbhD6JagOLI6glgWkigVhNJROBWYFPT4J+AQEBj?=
 =?us-ascii?q?w8hgTYIARUIEgEKAY5bAQE?=
X-IronPort-AV: E=Sophos;i="5.68,218,1569308400"; 
   d="scan'208";a="430003496"
Received: from unknown (HELO [128.196.149.246]) ([128.196.149.246])
  by mails1n1out.email.arizona.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 17:34:51 -0700
To:     linux-nfs@vger.kernel.org
From:   Chandler <admin@genome.arizona.edu>
Subject: NFS hangs on one interface
Message-ID: <3447df77-1b2f-6d36-0516-3ae7267ab509@genome.arizona.edu>
Date:   Tue, 22 Oct 2019 17:34:51 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all, I'm sure you get this alot, but I couldn't figure out any solution.  We have a client/server pair with both 1Gb and 10Gb network interfaces.  I can mount the share on the client on the 1Gb interface just fine and interact with it normally.  If I unmount and try to mount the share on the 10Gb interface, it will mount but everything after that hangs (like ls or df).  The exports entry is the same on the server, i.e.:

#1Gb interface
/data   10.10.10.0/24(rw,no_root_squash,async)
#10Gb interface
/data   128.196.X.X/28(rw,no_root_squash,async)

I turned off iptables for troubleshooting and checked with the NOC here.  Using NFSv4 by default and CentOS 6.10 2.6.32 kernel.  I had some strange results if i try vers=3 or vers=2, then i can "ls /data" but if I try to "ls /data/subdir" then it hangs again.  Now it doesn't even mount if i try with vers=3 or vers=2


