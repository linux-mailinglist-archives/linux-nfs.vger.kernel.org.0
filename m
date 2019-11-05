Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DECF1EF1F2
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2019 01:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbfKEA3B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Nov 2019 19:29:01 -0500
Received: from mails1n1-route0.email.arizona.edu ([128.196.130.51]:29165 "EHLO
        mails1n1-route0.email.arizona.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729137AbfKEA3A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Nov 2019 19:29:00 -0500
IronPort-SDR: G3dfooumYZ4ise0pIpLXivRKFJwc9vMWCCaDFyTQfiqDC6y2j8aImBaItKQJ5SWl60XXJEYXsK
 PaCopOyoOARg==
IronPort-PHdr: =?us-ascii?q?9a23=3AphfUsROE44wgzAkd/bMl6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0LfvyrarrMEGX3/hxlliBBdydt6sfzbOP7+u6ASQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagb75+Ngi6oRjeu8UZn4duNrs6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gyoBKjU38nzYitZogaxGoByvuRJ/zY3abo6aNvVxYqzTcMgGRW?=
 =?us-ascii?q?dDRMtdSzBNDp++YoYJEuEPPfxYr474p1YWsxa+BROjBOXyxT9MmHD2x7Ax3u?=
 =?us-ascii?q?M7Hg7b2QwgHtQOvW/brNrrMqcSVuW1w7fSwTrZdfNW2Db86I/Och87u/2DQ6?=
 =?us-ascii?q?9/cdfIxEQpCgjLjU2QpJT4Mz+L1ekBqXWX4u5hWO61lmIqpAV8riKxysoihY?=
 =?us-ascii?q?TEgJ8exEre+iVj2ok1IMW1SEt8YdG5DpRdrzqaN45qQsM6RGFopTo6xqUGuZ?=
 =?us-ascii?q?GleCgKz4wqyBrCZ/CZcIWE+A/vWeKQLDtimX5od7ayiwys/UWuxeDzUNG40F?=
 =?us-ascii?q?dMriVbjtnBrm0B2wLQ58SdV/dw+kas1SyS2w3c7uxIO144mKTUJpI5x74/jJ?=
 =?us-ascii?q?sTsUDNHi/sn0X2ibebeV859eit6uTnZK7rppCCOI9yjQH+N7ohltalDuQiMw?=
 =?us-ascii?q?gPXm+b+eKm27H540L2XahKguUskqbFqJDaOdgbpqmhDg9R04Yj7Qu/Dji/3N?=
 =?us-ascii?q?Qek3kHN0lIeAyIj4f3IVHCOvP4Aumlg1Sqjjhrw+rKPrr7ApXCfTD/l+Kreb?=
 =?us-ascii?q?d79l4ZzgQo5c5Q6ogSCbwbJv/3HEjru5aQWhs4NRGkhuDpE/1j2Y4EH2GCGK?=
 =?us-ascii?q?mUNOXVq1Detcw1JOzZT48cvjr5JuJts/fiiH4/sVAQe66s0N0ecnGqGfJvZU?=
 =?us-ascii?q?iVfCy/0Z86DW4Ws19mH6TRg1qYXGsLag=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2A5DAAvwcBd/+qVxIBmHgFDDIFXg18?=
 =?us-ascii?q?gEoRTiQOFGpJdg0yHbxIBCAEBAQ4TGQECAQGEQAKEMjgTAgMLAQEBBAEBAQE?=
 =?us-ascii?q?BBQICAWyEa01NARABgWcignUGGQoVUQgDDQ0CJgICVwaDNYJTJbBYgTIaiDo?=
 =?us-ascii?q?fCYFVgQ4oAYc5hHF4gQeBOAyCXz6HVYJeBIE5iGKMH0SWdB+CD4EYBV+TNAY?=
 =?us-ascii?q?bgiwBghKJdQOLLo5CmX+BaSKBWE0lE4FZgU9PkhEhgTUIARUIEgEKAYgDhSQ?=
 =?us-ascii?q?BAQ?=
X-IPAS-Result: =?us-ascii?q?A2A5DAAvwcBd/+qVxIBmHgFDDIFXg18gEoRTiQOFGpJdg?=
 =?us-ascii?q?0yHbxIBCAEBAQ4TGQECAQGEQAKEMjgTAgMLAQEBBAEBAQEBBQICAWyEa01NA?=
 =?us-ascii?q?RABgWcignUGGQoVUQgDDQ0CJgICVwaDNYJTJbBYgTIaiDofCYFVgQ4oAYc5h?=
 =?us-ascii?q?HF4gQeBOAyCXz6HVYJeBIE5iGKMH0SWdB+CD4EYBV+TNAYbgiwBghKJdQOLL?=
 =?us-ascii?q?o5CmX+BaSKBWE0lE4FZgU9PkhEhgTUIARUIEgEKAYgDhSQBAQ?=
X-IronPort-AV: E=Sophos;i="5.68,268,1569308400"; 
   d="scan'208";a="433351748"
Received: from unknown (HELO [128.196.149.234]) ([128.196.149.234])
  by mails1n1out.email.arizona.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 17:28:59 -0700
Subject: Re: NFS hangs on one interface
From:   Chandler <admin@genome.arizona.edu>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <3447df77-1b2f-6d36-0516-3ae7267ab509@genome.arizona.edu>
 <20191023171523.GA18802@fieldses.org>
 <b6248a82-1f1a-7329-5ee0-6e026f6db697@genome.arizona.edu>
 <YTBPR01MB2845B12E9C59F837FE35F40DDD650@YTBPR01MB2845.CANPRD01.PROD.OUTLOOK.COM>
 <82ee292f-f126-9e9f-d023-deb72d1a3971@genome.arizona.edu>
Openpgp: preference=signencrypt
Message-ID: <1079a074-7580-e257-8b52-6e48f8822176@genome.arizona.edu>
Date:   Mon, 4 Nov 2019 17:28:58 -0700
MIME-Version: 1.0
In-Reply-To: <82ee292f-f126-9e9f-d023-deb72d1a3971@genome.arizona.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Any ideas what's going on here?
Thanks
