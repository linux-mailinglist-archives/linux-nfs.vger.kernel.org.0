Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9BD3D64EC
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jul 2021 18:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbhGZQRZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jul 2021 12:17:25 -0400
Received: from p3plsmtpa07-04.prod.phx3.secureserver.net ([173.201.192.233]:39525
        "EHLO p3plsmtpa07-04.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240793AbhGZQOu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Jul 2021 12:14:50 -0400
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jul 2021 12:14:47 EDT
Received: from [192.168.0.100] ([68.239.50.225])
        by :SMTPAUTH: with ESMTPSA
        id 83qYmxVEiGpY083qZmvrc8; Mon, 26 Jul 2021 09:52:55 -0700
X-CMAE-Analysis: v=2.4 cv=T/1J89GQ c=1 sm=1 tr=0 ts=60fee867
 a=Rhw2r8FBodfaBxRKvGSZLA==:117 a=Rhw2r8FBodfaBxRKvGSZLA==:17
 a=IkcTkHD0fZMA:10 a=AGLkvWKIh2AzmkgO7fkA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v1 0/3] Optimize NFSD Send completion processing
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        linux-rdma@vger.kernel.org
References: <162731055652.13580.8774661104190191089.stgit@klimt.1015granger.net>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <c59afd87-b53a-25e7-8a22-efc8428bd75b@talpey.com>
Date:   Mon, 26 Jul 2021 12:52:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <162731055652.13580.8774661104190191089.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfNVCFhJ5grCMO0aqdV1vCYs9UGaNohHbIljlQXq3ZV2VA+Oja88mR5QOgTpUUkSfdYwkPJ8yitUjJuzbZnkp16xYvbM71MUaLWeb1LDsWQM0pHlhF7Fq
 2Grnr8DKrLT/NeNc/K+ZIO6Z+4JNP2OUOT09VUX+zzsWSZVEGwVnTlXlwiSSxhEjRdXlVp+g2yvO/Zjf60m/ZpBeTFl0pQUTzUP1gKZn5qWFcGM0Al33KiYE
 JF+RmkCo7RiITLNBjUH2pn5aSCynoWYCgb/MFHWlj3c=
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 7/26/2021 10:46 AM, Chuck Lever wrote:
> The following series improves the efficiency of NFSD's Send
> completion processing by removing costly operations from the svcrdma
> Send completion handlers. Each of these patches reduces the CPU
> utilized per RPC by Send completion by an average of 2-3%.

Nice gain. Are the improvements additive, i.e. 5-10% CPU reduction
for all three together?

Tom
