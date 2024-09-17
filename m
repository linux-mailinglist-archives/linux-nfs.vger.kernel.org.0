Return-Path: <linux-nfs+bounces-6529-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB9297B239
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Sep 2024 17:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516FD1F2B06B
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Sep 2024 15:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044FE192D81;
	Tue, 17 Sep 2024 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EQXQvOWJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CJbFWcMc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E081A17A918;
	Tue, 17 Sep 2024 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726587646; cv=fail; b=HJHpo8jA/jnXZpVGlTHybIZlyOk07g5pN0SAZjrYX7qJTGs8aND+T6+Z2/aFwcIChaN7Roj7GD7SydkWsETmm1KSLFd8IfE5vs9VwyyWrFPX68RV7xzf5HXFuyV0DKfQV44SGvo8O8SgafNdNJUltaAA6LSGLZUtqZsEXoJdYCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726587646; c=relaxed/simple;
	bh=igRDsMjCJHg62BtPJSDWHlLw7UmxZvMX/SeLlyJbpxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jPfFtKoFRZxD2tOe6Q/7GpnGePPjqNlw2QlqTkKmrWNIAMz/HxYKJCixLxLVehlWUxW8Bgg/N8wzYc4PLGPhBpIw1VU/5FFE1p0xqqyaMtF3QEJELUN9rQkie6ptZ+2pC8fs3yozAm53ahyN2AEuFuyGtnuRsNfG+S9YViBQ9HM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EQXQvOWJ; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CJbFWcMc reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48HEMbBR027049;
	Tue, 17 Sep 2024 15:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=7hqry/q4IDkbdKb0A/BXueHfOWnJ+TskWc3VPCulQi8=; b=
	EQXQvOWJuVKOV5f0kDKad+tcBj9nWuYMZ+/0CvpFkXOhnmVgLZAxJ42L9yJ15lbX
	+NBQDsPbOU5f6QJSN7nm/7/vPk7Gq4v2dMJvk5O4jAwvm88MEwJP7t2YlErfMtjb
	4dA0PBO5a0t0cpfwzlqNainx0lmoJws9ic3Z6Iqv81D+6Ktm/JrUzUbi8hC3B+kL
	xbt3W0faS2MWIUjU1YAeiYLkIEhenjLMGGCFGFD+PrK439cfEqYvI+LWc293VW9i
	nkewv3cPpaZyTOceFdCzTKT5RYoxa7B9rCvH26QUutlx+romKtCRH3WSjtLFy4DR
	PghM6nzhrwpIuwDvwbJaiA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3nfphfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 15:40:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48HEKfiS017909;
	Tue, 17 Sep 2024 15:40:13 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nycwt84x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 15:40:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAuG/hOfBCw6sV7fzJz1skDvAHNx2nxzwd3nhJ6exgIQul+za1TEFOhewlFdKIX4RS5jI6D3XYdqJgdomPptMQv7A6+v2dYik88YH3L8ILCGQmoD8WZy/X0ZqsoYZoanit7noBYm69StDIDO407ap/Mzsfwb2LjUpyDHUX9JcHfB+/JmMawhQyrE7JZlGquGn6TFHr3l0qxATPXaximoMV95CAsg9o0PwLKq/5xv/EmRE+gmUqwYE7E6CEiNCQlfBLbcZ36WmKOzxoT8NIUA+1yEHDbdvtF8O9Dkgp20PZPyo/opz28suPYkE2FgnW4LzmXN81Fo4V7I61in2CkObA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDduu68g47DmpQPe1G8fbeXT+Rx21MDdkPB76/u28ko=;
 b=rCgeOGtCmzJs28Dh46oCzk0cQlZcVArOWiG+f+W6oQR5i5ROgsD55LT2Bu33Gzx6hQO70/T3C6GSvQaBNEgFvG5Yg+HRSWD5qbyZsTT/wA9gXOgiGLVqbnlXEaQvclf5y4zL0YNP+qaJaPfJss7SqrikoBt7JTaRVO28qnPjzRdn2ODACvNJYLlAQrGpByrW22Q0iIoNA7xAuc3tfgHNHUKSEPB3BHKsHZnKm7XHKjQ3E8sRpsltCaMJekj6zI+Eg5acAoC9m+wN0x5BEKLNYRqples673CTFT5WS2urRiukmvlWV/oEqkLGFP6h8b/Y+Wr2FbP7ZiuMVc7YoYbhwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDduu68g47DmpQPe1G8fbeXT+Rx21MDdkPB76/u28ko=;
 b=CJbFWcMcg9rKwHrQ3eq0otwF/OWOeQRz2tZ9Ibubhvu7Cfd9HhfTkbM4tKmLcWkosAHQUJkyy/ttS7/H01UyCX2EEiMN92ghJMLlsNM69qxKFJKudgOmCrxTlNnmyivPISHr1hp2d24c6JKBrTjIkUSZxaYM1jg6TxRfrtnR5k8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7247.namprd10.prod.outlook.com (2603:10b6:8:fb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.15; Tue, 17 Sep
 2024 15:40:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7982.012; Tue, 17 Sep 2024
 15:40:09 +0000
Date: Tue, 17 Sep 2024 11:39:58 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Add support for mapping sticky bit into NFS4 ACL
Message-ID: <Zumizr3WnA+XY9ge@tissot.1015granger.net>
References: <20240912221523.23648-1-pali@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240912221523.23648-1-pali@kernel.org>
X-ClientProxiedBy: BYAPR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd53084-4dd0-4500-e1da-08dcd72efefe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?2FuB7xoWmOeEWIObNb0pnTaEgVim0qVmSYa1vJul5I/KJ5aWv7m4+/5A7X?=
 =?iso-8859-1?Q?eXMhX5O98DQDT588O/EAJ90oc4kEmVf3Vf8KQesL/RK0GF7a3HkhYYj5vU?=
 =?iso-8859-1?Q?oMBIYkAZpQkuSpvONaAS8BjD6TayouEAWM1wncmDcVcFmI1uzKveU7l5NJ?=
 =?iso-8859-1?Q?U9hXa4UGwU8dUxC6T4itJhaJLx7Q1ljdx0WZBQ+j88AVI+U7Nc3A9UQzJU?=
 =?iso-8859-1?Q?/4qZP5IyaTP0QnrtuMlJECafllvsZfquxRo8jAnpubivCHB6LTEySY+vHj?=
 =?iso-8859-1?Q?ze0lWLkbeW4O5wHrNihSa1M42cppiSD4KTOvPRZf0Ls+y6R0hb0SUYDsH7?=
 =?iso-8859-1?Q?P8/OTP2x7GMadoR2jlVO6TGsATydj5br4j6x+4sHZgyZ7QrA3JxHficupd?=
 =?iso-8859-1?Q?efpM89HMMXXhA8fmPJZ5SKi0jIZ64unxqFbrKLwVxRq69d2JY11rd6vXN4?=
 =?iso-8859-1?Q?KiSavFpADG3j3mhFiz7A7bW4IJAkRHLM5ojpwVY22z60kYDugfYjC3ueTj?=
 =?iso-8859-1?Q?uUnQ8ocBgrKFddkh5qo6Hx7/xbpahemZQ8HgK9N9976c5BueRO2w0yfW14?=
 =?iso-8859-1?Q?jU3nLHLV+1oLm8KdSewdl0CUbBx9OiKdFSja0ghH1EI/1LbO0DkfFEbxUW?=
 =?iso-8859-1?Q?x8mNmFxL5wVRGLIChHrKbZP2ZftXARhwJryopFO0HYMdNyEdVqQr8iwqM8?=
 =?iso-8859-1?Q?jqQD/obU+sZ5gGODU5D2/lBbfM8XrabV6O8VxRdPLs9XHmX9mVJjGoVeDT?=
 =?iso-8859-1?Q?Dh7mXlfH8YW5o6Z0lz8fVQV+mlD2HgSIjGVhZXTidWmvITSyTuoWDuKF1n?=
 =?iso-8859-1?Q?GMfv3dXaufN1Uks8FHLawy//CNz+z5u9mDEpFgatZg8u6kNKJce3NLMf3D?=
 =?iso-8859-1?Q?C3HRPtZgEhtulCwYA8qsV3Lrqlpot1n8VflnpBaBv82lnTGzFaRXA5/eiR?=
 =?iso-8859-1?Q?vEzGL/sV+NW0OUpPMHa/TzraB9WsSmJ6a922ja5LPynmaCOqdq5wS5scem?=
 =?iso-8859-1?Q?OINxlPUxTlm3pXCWGxBVfMlNwS4XAmjbbRcV+5+DBIXcZuRAnfVbBO5je1?=
 =?iso-8859-1?Q?NNI2VbXF+9s48M0kyKXHARxFfhyodrNK6WsLZDNZnLceuDCLeH1nainAo0?=
 =?iso-8859-1?Q?jq2rryWYuOfneRYyXncW3untqlHbUp655toWzebjwSABRwi1SLpxGCyVAI?=
 =?iso-8859-1?Q?jtbnWYDsXCgiZuLH1aCLBFJQTAPoG5UEZbwFSLq+t/HfZoX+lSMTV8eVw/?=
 =?iso-8859-1?Q?il4AI1PHSK8liatrFNgdhvfCXYpXse5JIareUASXRzabzLHjTZ4txgf4oq?=
 =?iso-8859-1?Q?1F+TVU/h2NCs2YfZC4EVFdFLhojlE6Rj9wRTbtuXi+XlDiqTC0Udqz0TQw?=
 =?iso-8859-1?Q?DQxvqM1v78BrzdguQC1NN/SH+VD4FwZg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?rEkniNSF9F3RlMLa/9Zud6tuqc5w4mDOhLRN9Jzp50e3QJcGdjyzluzezy?=
 =?iso-8859-1?Q?qe5PsYfbJjk5h12HIDaBNSz1vX35gNp2+jsjmPs3pHYAn+7YmwNQVAKJOQ?=
 =?iso-8859-1?Q?VYLg4uGi7Dmc4P8xKQ1Lpx4sxYGpFI/IjVRnEgK473MGY4Hw+/evPpnpDI?=
 =?iso-8859-1?Q?qVTT9MApcvACcehp3CNKeof8rglTMpgSRqtxkpJYldSM0Nv2cvZ1+eRM49?=
 =?iso-8859-1?Q?1EDhkaKdFIashONLSq5HcWLbf+freuGdIF5yUS6w2qGndXrsa8NTmG5KAw?=
 =?iso-8859-1?Q?XL94SIl6AKj5Qp43rlfYYTrQAmkWHYAeEqR3QsnLNyVYAXKMl+pdls4oL2?=
 =?iso-8859-1?Q?GE2+/vZszD983cUNvoHFAQ73Lm2KT6tkZt94u6hcfTktzQN2Ueb7vrFbzZ?=
 =?iso-8859-1?Q?q7R5ktS7s/wEX+YxUx21QiJfqygRHCOwaByrK9o5/46yywXhQMRROSGTNJ?=
 =?iso-8859-1?Q?L/oCOyVYBqTjQKxg7XX4PmEpghw3qJtYrwDCpx12uA9JgunzMDlOY6KDez?=
 =?iso-8859-1?Q?+I8PAkmFKRNo+fMaF5PJEN2zldXa7hkQDpsEdletc4XTzsSRnv2ZwuA/jM?=
 =?iso-8859-1?Q?QKd+8JoCIjrtbM5fi0MzxHDeM4W4PhROwUy/JjijUaSbNP1SPSId269cZt?=
 =?iso-8859-1?Q?3LbbUuZV12EOVSgH3wqkZk8EjLconpCLrS3YL1FsYBJljYoMzAGDh7xbXI?=
 =?iso-8859-1?Q?q6JcFp4LmA3k1mujU0e8AV+9kcBdB/b84sVHFWtYPtaKYWzgsfru7eMc/4?=
 =?iso-8859-1?Q?UJcBEjUnGKEAs/7FIlc7d05Q+5r27/gs1NHXDFd2OrkQ1l6CLsx8WA1Acx?=
 =?iso-8859-1?Q?fUhmVHqrdQBse/vUSKA79F//CLCIqn4lf/9axvrNEazvX7+LY2zhvI4L3l?=
 =?iso-8859-1?Q?lkOS2hjaX6R3gTfKBGCH31OmGsCTEQj98A2pQlriS8LmzAzlYDkmdlQbZr?=
 =?iso-8859-1?Q?B/DKR5W39zwO4J7KwiLeeXABB2NrfjwuR3NczU2ZtI2P0rpdU8f960PZrr?=
 =?iso-8859-1?Q?StyEbuj8kpKs7sMopobOrtra+t1G4ceiBBuh7usJB0OmvFhnQTgEgoy9wF?=
 =?iso-8859-1?Q?srCMkaPKKnU2kceqWMkxlyp9kkPlsNMX3e61k1FV2JL91jXy2MOTL0bvqF?=
 =?iso-8859-1?Q?NOlP0JBdyotsfz7tsqYgPCiHf5MwikMQ2JG5L4uinY4wpCZfRO+60Y29Eh?=
 =?iso-8859-1?Q?4kyLonUHjV7jaKU5GtKUYsuVl2gDJrnAzu3Xmjz1pZywMA/9cWguIZuQN4?=
 =?iso-8859-1?Q?ra/cDMnatmT8AgCRczdG3p7g/zoD5IR8TBp6U26PHR+/9pbe4d3IWAcuIC?=
 =?iso-8859-1?Q?ox/mEWU3Q07357SDVzdq3foGjOBGoRWm436aPZ0SbpMKeFba7886sA1i8A?=
 =?iso-8859-1?Q?sC8F8CYUq+ALChKTzEHvRtUEemnFWQxteDVQmmSzmoGeZV95NIJ/VjJ0eH?=
 =?iso-8859-1?Q?/rrGnuksS1ug/gJzQoFWVp3mJ2ce9cfFDd67DpUtQZjWdVBgGKzzxGyXj6?=
 =?iso-8859-1?Q?BzDQCHvX40v1S2Brcj7pwdnuDfa1dTyh4/OTo42RDqkP/7i3WMQTEep4Ll?=
 =?iso-8859-1?Q?zHbbKYYsoimgvZk5Qo+UOtTPm5kQQcufE9I9HhfggzbGWyF9uErUC1xyYS?=
 =?iso-8859-1?Q?1R3bImhcs9GjpejVoQ/u94YNaga0bx/Ppz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GV76KRhFLHeWWylCeX6gS/MZqTxkASOqt+VU0FszJY71gG7nfPRi6sQzSH7E7ls0dpwed1WKhdH5V46i7iD5H9RxDjSdZec6uDBiX2zo90AlW2o+54xQikFlE9VLzhmZU0QBh7sfaiJ0UnKyM5HnHvMewHniGdtq2WV0c96PzMk4mAS7Ugr/GgcZwT67HsswXvjnzQoWUmuuDyAyyMecIqp1mMYcycKfyfrSsI/XRm+U+G52Wexn7jnyCKcBaUpzSVFdk+J3aazagH5KzPEmq3iiC0CmEYMSQNnA9buZ90Jo5FV3lSTx1WRmVfXZMlqT1ZYStMvowjKGbfKhVc15KVcEcmwWWNA9RyXiuJ7k1c2O81mfiUP4jT/hwQuXdk/5jzMWcXfG/FEPhYRWS69eZVxcAYT3o3k9Fk/l0Ogb1VhoYepf1bgwRR8NKuNN0+G9hrZfY+ONS+v17SXSasBUAbyN9qxXnnPOWwPuq6/XbfqCnY3J8CwafC3Uk+u/wAD8vET+kR7muCNlNkrx6Ok0sDGMZp7deTWgHP5QuYUGr+41m+ztgIlD6OYErNv8eGFq/cKBrVkV39xDLaKRZKSrhajj5Mu1giGRt9kaSuwxHGA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd53084-4dd0-4500-e1da-08dcd72efefe
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 15:40:09.7608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IGzfM9Pon3qq75zNQYMVlzDbb7Gf7ulTM0BOi1Zjp5c+/AwnQO3Fzh9DXwW2JoIcj4Rowybed3vygoReyFu/XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7247
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_08,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409170112
X-Proofpoint-GUID: yUJW8m_U1178x0KeOUk47x6xtJR8AwH8
X-Proofpoint-ORIG-GUID: yUJW8m_U1178x0KeOUk47x6xtJR8AwH8

On Fri, Sep 13, 2024 at 12:15:23AM +0200, Pali Rohár wrote:
> Currently the directory restricted deletion flag (sticky bit, SVTX) is not
> mapped into NFS4 ACL by knfsd. Which means that the NFS4 ACL client is not
> aware of the fact that it cannot delete some files if the sticky bit is set
> on the server on parent directory. If the client copies sticky bit
> directory recursively to some other storage which implements the NFS4-like
> ACL (e.g. to NTFS filesystem or to SMB server) then the directory's
> restricted deletion flag is completely lost.
> 
> This change aims to improve interoperability of the POSIX directory
> restricted deletion flag (sticky bit, SVTX) and NFS4 ACL structure in
> knfsd. It transparently maps POSIX directory's sticky bit into NFS4 ACL
> and vice-versa similarly like it already maps POSIX ACL into NFS4 ACL.
> It covers NFS4 GETATTR ACL, NFS4 SETATTR ACL, NFS4 CREATE+OPEN operations.
> When creating a new object over NFS4, it is possible to optionally specify
> NFS4 ACL, so this is covered too.
> 
> For client SETATTR ACL, CREATE with ACL and OPEN-create with ACL
> operations, detection pattern for restricted deletion flag is ACE entry
> INHERIT_ONLY NO_PROPAGATE ALLOW OWNER@ DELETE together with check that
> nobody except the OWNER@ has DELETE_CHILD permission. Note that the OWNER@
> does not have to have DELETE_CHILD permission in case it does not have
> write access to directory.
> 
> For client GETATTR ACL operation, when restricted deletion flag is present
> in inode, following ACE entries are prepended before any other ACEs:
> 
>   ALLOW OWNER@ DELETE_CHILD                                 (1)
>   DENY EVERYONE@ DELETE_CHILD
>   INHERIT_ONLY NO_PROPAGATE DENY user_owner_of_dir DELETE   (3)
>   INHERIT_ONLY NO_PROPAGATE DENY OWNER@ DELETE              (4)
>   INHERIT_ONLY NO_PROPAGATE DENY user1 DELETE               (ACL user1)
>   ...
>   INHERIT_ONLY NO_PROPAGATE DENY userN DELETE               (ACL userN)
>   INHERIT_ONLY NO_PROPAGATE ALLOW OWNER@ DELETE
> 
> ACE entry (1) is present only when user OWNER@ has write access (can modify
> directory, including removing child entries), because it is possible to
> have sticky bit set also on read-only directory.
> 
> ACE entry (3) is present only when user OWNER@ does not have write access
> (cannot modify directory) and it is required to override effect of the last
> ACE entry which allows child entry OWNER@ to remove entry itself. This is
> needed for example for POSIX mode 1577.
> 
> ACE entry (4) is present only when anybody else except the directory owner
> has no write access to the directory. This is the case when sticky bit is
> set but nobody can use it because of missing directory write access. So
> this explicit DENY covers this edge case.
> 
> ACE entries (ACL user1...userN) are for POSIX users which do not have write
> access to directory and therefore they cannot remove directory entries
> which they own. This is again needed for overriding the effect of the last
> ACE entry.
> 
> When restricted deletion flag is not present then nothing is added.
> 
> This is probably the best approximation of the directory restricted
> deletion flag. It covers directory's OWNER@ grant access, child OWNER@
> grant access and also restrictions for all other users. It also covers the
> situation when OWNER@ or some POSIX user does not have write access to the
> directory, and also covers situation when nobody except directory owner has
> write access to the directory.
> 
> What this does not cover is the restriction when some POSIX group does not
> have directory write access, and another POSIX group has directory write
> access. This is probably not possible to express in NFS4 ACL language
> without ability to evaluate if user is member of some group or not. NFS4
> ACL in this case says for the owner of the file that the delete operation
> is allowed.
> 
> The whole change is only about the mapping of the sticky bit into NFS4 ACL
> and only for NFS4 GET and SET ACL operations. It does not change any access
> permission checks.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  fs/nfsd/acl.h      |   2 +-
>  fs/nfsd/nfs4acl.c  | 242 ++++++++++++++++++++++++++++++++++++++++++---
>  fs/nfsd/nfs4proc.c |  31 +++++-
>  3 files changed, 255 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/nfsd/acl.h b/fs/nfsd/acl.h
> index 4b7324458a94..e7e7909bf03a 100644
> --- a/fs/nfsd/acl.h
> +++ b/fs/nfsd/acl.h
> @@ -48,6 +48,6 @@ __be32 nfs4_acl_write_who(struct xdr_stream *xdr, int who);
>  int nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
>  		struct nfs4_acl **acl);
>  __be32 nfsd4_acl_to_attr(enum nfs_ftype4 type, struct nfs4_acl *acl,
> -			 struct nfsd_attrs *attr);
> +			 struct nfsd_attrs *attr, int *dir_sticky);
>  
>  #endif /* LINUX_NFS4_ACL_H */
> diff --git a/fs/nfsd/nfs4acl.c b/fs/nfsd/nfs4acl.c
> index 96e786b5e544..6a53772c2a13 100644
> --- a/fs/nfsd/nfs4acl.c
> +++ b/fs/nfsd/nfs4acl.c
> @@ -46,6 +46,7 @@
>  #define NFS4_ACL_TYPE_DEFAULT	0x01
>  #define NFS4_ACL_DIR		0x02
>  #define NFS4_ACL_OWNER		0x04
> +#define NFS4_ACL_DIR_STICKY	0x08
>  
>  /* mode bit translations: */
>  #define NFS4_READ_MODE (NFS4_ACE_READ_DATA)
> @@ -73,7 +74,7 @@ mask_from_posix(unsigned short perm, unsigned int flags)
>  		mask |= NFS4_READ_MODE;
>  	if (perm & ACL_WRITE)
>  		mask |= NFS4_WRITE_MODE;
> -	if ((perm & ACL_WRITE) && (flags & NFS4_ACL_DIR))
> +	if ((perm & ACL_WRITE) && (flags & NFS4_ACL_DIR) && !(flags & NFS4_ACL_DIR_STICKY))
>  		mask |= NFS4_ACE_DELETE_CHILD;
>  	if (perm & ACL_EXECUTE)
>  		mask |= NFS4_EXECUTE_MODE;
> @@ -89,7 +90,7 @@ deny_mask_from_posix(unsigned short perm, u32 flags)
>  		mask |= NFS4_READ_MODE;
>  	if (perm & ACL_WRITE)
>  		mask |= NFS4_WRITE_MODE;
> -	if ((perm & ACL_WRITE) && (flags & NFS4_ACL_DIR))
> +	if ((perm & ACL_WRITE) && (flags & NFS4_ACL_DIR) && !(flags & NFS4_ACL_DIR_STICKY))
>  		mask |= NFS4_ACE_DELETE_CHILD;
>  	if (perm & ACL_EXECUTE)
>  		mask |= NFS4_EXECUTE_MODE;
> @@ -110,7 +111,7 @@ low_mode_from_nfs4(u32 perm, unsigned short *mode, unsigned int flags)
>  {
>  	u32 write_mode = NFS4_WRITE_MODE;
>  
> -	if (flags & NFS4_ACL_DIR)
> +	if ((flags & NFS4_ACL_DIR) && !(flags | NFS4_ACL_DIR_STICKY))
>  		write_mode |= NFS4_ACE_DELETE_CHILD;
>  	*mode = 0;
>  	if ((perm & NFS4_READ_MODE) == NFS4_READ_MODE)
> @@ -123,7 +124,7 @@ low_mode_from_nfs4(u32 perm, unsigned short *mode, unsigned int flags)
>  
>  static short ace2type(struct nfs4_ace *);
>  static void _posix_to_nfsv4_one(struct posix_acl *, struct nfs4_acl *,
> -				unsigned int);
> +				unsigned int, kuid_t);
>  
>  int
>  nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
> @@ -142,8 +143,11 @@ nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
>  	if (IS_ERR(pacl))
>  		return PTR_ERR(pacl);
>  
> -	/* allocate for worst case: one (deny, allow) pair each: */
> -	size += 2 * pacl->a_count;
> +	/*
> +	 * allocate for worst case: one (deny, allow) pair for each
> +	 * plus for restricted deletion flag (sticky bit): 4 + one for each
> +	 */
> +	size += 2 * pacl->a_count + (4 + pacl->a_count);
>  
>  	if (S_ISDIR(inode->i_mode)) {
>  		flags = NFS4_ACL_DIR;
> @@ -155,6 +159,10 @@ nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
>  
>  		if (dpacl)
>  			size += 2 * dpacl->a_count;
> +
> +		/* propagate restricted deletion flag (sticky bit) */
> +		if (inode->i_mode & S_ISVTX)
> +			flags |= NFS4_ACL_DIR_STICKY;
>  	}
>  
>  	*acl = kmalloc(nfs4_acl_bytes(size), GFP_KERNEL);
> @@ -164,10 +172,10 @@ nfsd4_get_nfs4_acl(struct svc_rqst *rqstp, struct dentry *dentry,
>  	}
>  	(*acl)->naces = 0;
>  
> -	_posix_to_nfsv4_one(pacl, *acl, flags & ~NFS4_ACL_TYPE_DEFAULT);
> +	_posix_to_nfsv4_one(pacl, *acl, flags & ~NFS4_ACL_TYPE_DEFAULT, inode->i_uid);
>  
>  	if (dpacl)
> -		_posix_to_nfsv4_one(dpacl, *acl, flags | NFS4_ACL_TYPE_DEFAULT);
> +		_posix_to_nfsv4_one(dpacl, *acl, (flags | NFS4_ACL_TYPE_DEFAULT) & ~NFS4_ACL_DIR_STICKY, inode->i_uid);
>  
>  out:
>  	posix_acl_release(dpacl);
> @@ -231,7 +239,7 @@ summarize_posix_acl(struct posix_acl *acl, struct posix_acl_summary *pas)
>  /* We assume the acl has been verified with posix_acl_valid. */
>  static void
>  _posix_to_nfsv4_one(struct posix_acl *pacl, struct nfs4_acl *acl,
> -						unsigned int flags)
> +		    unsigned int flags, kuid_t owner_uid)
>  {
>  	struct posix_acl_entry *pa, *group_owner_entry;
>  	struct nfs4_ace *ace;
> @@ -243,9 +251,149 @@ _posix_to_nfsv4_one(struct posix_acl *pacl, struct nfs4_acl *acl,
>  	BUG_ON(pacl->a_count < 3);
>  	summarize_posix_acl(pacl, &pas);
>  
> -	pa = pacl->a_entries;
>  	ace = acl->aces + acl->naces;
>  
> +	/*
> +	 * Translate restricted deletion flag (sticky bit, SVTX) set on the
> +	 * directory to following NFS4 ACEs prepended before any other ACEs:
> +	 *
> +	 *   ALLOW OWNER@ DELETE_CHILD                                 (1)
> +	 *   DENY EVERYONE@ DELETE_CHILD
> +	 *   INHERIT_ONLY NO_PROPAGATE DENY user_owner_of_dir DELETE   (3)
> +	 *   INHERIT_ONLY NO_PROPAGATE DENY OWNER@ DELETE              (4)
> +	 *   INHERIT_ONLY NO_PROPAGATE DENY user1 DELETE               (ACL user1)
> +	 *   ...
> +	 *   INHERIT_ONLY NO_PROPAGATE DENY userN DELETE               (ACL userN)
> +	 *   INHERIT_ONLY NO_PROPAGATE ALLOW OWNER@ DELETE
> +	 *
> +	 *   (1) - only if user-owner has write access
> +	 *   (3) - only if user-owner does not have write access
> +	 *   (4) - only if non-user-owner does not have write access
> +	 *   (ACL user1) - only if user1 does not have write access
> +	 *   (ACL userN) - only if userN does not have write access
> +	 *
> +	 * These ACEs describe behavior of set restricted deletion flag (sticky
> +	 * bit) on directory as they allow only owner of individual child entries
> +	 * and owner of the directory to delete individual child entries.
> +	 * Everyone else is denied to remove child entries in this directory.
> +	 *
> +	 * For deleting entry in NFS4 ACL model it is needed either DELETE_CHILD
> +	 * permission (access mask) from the parent directory or DELETE permission
> +	 * (access mask) on the child. Just one of these two permissions is enough.
> +	 * So if there is explicit DENY DELETE_CHILD on the parent together with
> +	 * explicit ALLOW DELETE on the child, it means that deleting is allowed
> +	 * (evaluation of permissions is independent in NFS4 ACL model). OWNER@
> +	 * for inherited ACEs means owner of the child entry and not the owner
> +	 * of the parent from which was ACE inherited.
> +	 *
> +	 * This translation is imperfect just for a case when some group
> +	 * (including group-owner and others-group) does not have write access
> +	 * to directory. Handled is only the edge case (via rule 4) when
> +	 * everyone else except owner has no write access to the directory.
> +	 * This information is not present in NFS4 ACL because it looks like that
> +	 * this is not possible to express in this ACL model. So for ACL consumer
> +	 * it could look like that owner of the file can delete its own file even
> +	 * when group or other mode bits of the directory do not allow it.
> +	 */
> +	if (flags & NFS4_ACL_DIR_STICKY) {
> +		/*
> +		 * Explicitly allow directory owner to delete child entries
> +		 * if directory owner has write access
> +		 */
> +		if (pas.owner & ACL_WRITE) {
> +			ace->type = NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE;
> +			ace->flag = 0;
> +			ace->access_mask = NFS4_ACE_DELETE_CHILD;
> +			ace->whotype = NFS4_ACL_WHO_OWNER;
> +			ace++;
> +			acl->naces++;
> +		}
> +
> +		/*
> +		 * And then deny deleting child entries for all other users
> +		 * which do not have explicit DELETE permission granted by
> +		 * last rule in this section.
> +		 */
> +		ace->type = NFS4_ACE_ACCESS_DENIED_ACE_TYPE;
> +		ace->flag = 0;
> +		ace->access_mask = NFS4_ACE_DELETE_CHILD;
> +		ace->whotype = NFS4_ACL_WHO_EVERYONE;
> +		ace++;
> +		acl->naces++;
> +
> +		/*
> +		 * Do not grant directory owner to delete child entries (by the
> +		 * last rule in this section) if it does not have write access.
> +		 */
> +		if (!(pas.owner & ACL_WRITE)) {
> +			ace->type = NFS4_ACE_ACCESS_DENIED_ACE_TYPE;
> +			ace->flag = NFS4_INHERITANCE_FLAGS |
> +				    NFS4_ACE_INHERIT_ONLY_ACE |
> +				    NFS4_ACE_NO_PROPAGATE_INHERIT_ACE;
> +			ace->access_mask = NFS4_ACE_DELETE;
> +			ace->whotype = NFS4_ACL_WHO_NAMED;
> +			ace->who_uid = owner_uid;
> +			ace++;
> +			acl->naces++;
> +		}
> +
> +		if (!(pas.users & ACL_WRITE) && !(pas.group & ACL_WRITE) &&
> +		    !(pas.groups & ACL_WRITE) && !(pas.other & ACL_WRITE)) {
> +			/*
> +			 * Do not grant child owner who is not directory owner
> +			 * (handled by the first rule in this section) to
> +			 * delete own child entries if there is no possible
> +			 * directory write permission (checked for named users,
> +			 * group-owner, named groups and others-groups).
> +			 * This handles special edge case when only directory
> +			 * owner has write access to directory.
> +			 */
> +			ace->type = NFS4_ACE_ACCESS_DENIED_ACE_TYPE;
> +			ace->flag = NFS4_INHERITANCE_FLAGS |
> +				    NFS4_ACE_INHERIT_ONLY_ACE |
> +				    NFS4_ACE_NO_PROPAGATE_INHERIT_ACE;
> +			ace->access_mask = NFS4_ACE_DELETE;
> +			ace->whotype = NFS4_ACL_WHO_OWNER;
> +			ace++;
> +			acl->naces++;
> +		} else {
> +			/*
> +			 * Do not grant individual named users to delete child
> +			 * entries (by the last rule in this section) if user
> +			 * does not have write access to directory.
> +			 */
> +			for (pa = pacl->a_entries + 1; pa->e_tag == ACL_USER; pa++) {
> +				if (pa->e_perm & pas.mask & ACL_WRITE)
> +					continue;
> +				ace->type = NFS4_ACE_ACCESS_DENIED_ACE_TYPE;
> +				ace->flag = NFS4_INHERITANCE_FLAGS |
> +					    NFS4_ACE_INHERIT_ONLY_ACE |
> +					    NFS4_ACE_NO_PROPAGATE_INHERIT_ACE;
> +				ace->access_mask = NFS4_ACE_DELETE;
> +				ace->whotype = NFS4_ACL_WHO_NAMED;
> +				ace->who_uid = pa->e_uid;
> +				ace++;
> +				acl->naces++;
> +			}
> +		}
> +
> +		/*
> +		 * Above rules filtered out users which do not have write access
> +		 * to the directory. Now allow child-owner to delete its own
> +		 * directory entries.
> +		 */
> +		ace->type = NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE;
> +		ace->flag = NFS4_INHERITANCE_FLAGS |
> +			    NFS4_ACE_INHERIT_ONLY_ACE |
> +			    NFS4_ACE_NO_PROPAGATE_INHERIT_ACE;
> +		ace->access_mask = NFS4_ACE_DELETE;
> +		ace->whotype = NFS4_ACL_WHO_OWNER;
> +		ace++;
> +		acl->naces++;
> +	}
> +
> +	pa = pacl->a_entries;
> +
>  	/* We could deny everything not granted by the owner: */
>  	deny = ~pas.owner;
>  	/*
> @@ -517,7 +665,8 @@ posix_state_to_acl(struct posix_acl_state *state, unsigned int flags)
>  
>  	pace = pacl->a_entries;
>  	pace->e_tag = ACL_USER_OBJ;
> -	low_mode_from_nfs4(state->owner.allow, &pace->e_perm, flags);
> +	/* owner is never affected by restricted deletion flag, so clear NFS4_ACL_DIR_STICKY */
> +	low_mode_from_nfs4(state->owner.allow, &pace->e_perm, flags & ~NFS4_ACL_DIR_STICKY);
>  
>  	for (i=0; i < state->users->n; i++) {
>  		pace++;
> @@ -691,9 +840,14 @@ static void process_one_v4_ace(struct posix_acl_state *state,
>  
>  static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl *acl,
>  		struct posix_acl **pacl, struct posix_acl **dpacl,
> +		int *dir_sticky,
>  		unsigned int flags)
>  {
>  	struct posix_acl_state effective_acl_state, default_acl_state;
> +	bool dir_allow_nonowner_delete_child = false;
> +	bool dir_deny_everyone_delete_child = false;
> +	bool dir_allow_child_owner_delete = false;
> +	unsigned int eflags = 0;
>  	struct nfs4_ace *ace;
>  	int ret;
>  
> @@ -705,6 +859,28 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl *acl,
>  		goto out_estate;
>  	ret = -EINVAL;
>  	for (ace = acl->aces; ace < acl->aces + acl->naces; ace++) {
> +		/*
> +		 * Process and parse ACE entry INHERIT_ONLY NO_PROPAGATE DELETE
> +		 * for detecting restricted deletion flag (sticky bit). Allow
> +		 * SYNCHRONIZE access mask to be present as NFS4 clients can
> +		 * include this access mask together with any other one.
> +		 *
> +		 * It needs to be done before validation as NFS4_SUPPORTED_FLAGS
> +		 * does not contain NFS4_ACE_NO_PROPAGATE_INHERIT_ACE and this
> +		 * ACE must not throw error.
> +		 */
> +		if ((flags & NFS4_ACL_DIR) &&
> +		    !(ace->flag & ~(NFS4_SUPPORTED_FLAGS|NFS4_ACE_NO_PROPAGATE_INHERIT_ACE)) &&
> +		    (ace->flag & NFS4_INHERITANCE_FLAGS) &&
> +		    (ace->flag & NFS4_ACE_INHERIT_ONLY_ACE) &&
> +		    (ace->flag & NFS4_ACE_NO_PROPAGATE_INHERIT_ACE) &&
> +		    (ace->access_mask & ~NFS4_ACE_SYNCHRONIZE) == NFS4_ACE_DELETE) {
> +			if (ace->type == NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE &&
> +			    ace->whotype == NFS4_ACL_WHO_OWNER)
> +				dir_allow_child_owner_delete = true;
> +			continue;
> +		}
> +
>  		if (ace->type != NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE &&
>  		    ace->type != NFS4_ACE_ACCESS_DENIED_ACE_TYPE)
>  			goto out_dstate;
> @@ -725,6 +901,38 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl *acl,
>  
>  		if (!(ace->flag & NFS4_ACE_INHERIT_ONLY_ACE))
>  			process_one_v4_ace(&effective_acl_state, ace);
> +
> +		/*
> +		 * Process and parse ACE entry with DELETE_CHILD access mask
> +		 * for detecting restricted deletion flag (sticky bit).
> +		 */
> +		if ((flags & NFS4_ACL_DIR) &&
> +		    !(ace->flag & NFS4_ACE_INHERIT_ONLY_ACE) &&
> +		    (ace->access_mask & NFS4_ACE_DELETE_CHILD)) {
> +			if (ace->type == NFS4_ACE_ACCESS_ALLOWED_ACE_TYPE &&
> +			    !dir_deny_everyone_delete_child &&
> +			    ace->whotype != NFS4_ACL_WHO_OWNER)
> +				dir_allow_nonowner_delete_child = true;
> +			else if (ace->type == NFS4_ACE_ACCESS_DENIED_ACE_TYPE &&
> +				 ace->whotype == NFS4_ACL_WHO_EVERYONE)
> +				dir_deny_everyone_delete_child = true;
> +		}
> +	}
> +
> +	/*
> +	 * Recognize restricted deletion flag (sticky bit) from directory ACL
> +	 * if ACEs on directory allow only owner of directory child entry to
> +	 * delete entry itself.
> +	 *
> +	 * This is relaxed check for rules generated by _posix_to_nfsv4_one().
> +	 * Relaxed check of restricted deletion flag is for security reasons
> +	 * and means that permissions would be more stricter, to prevent
> +	 * granting more access than what was specified in NFS4 ACL packet.
> +	 */
> +	if (flags & NFS4_ACL_DIR) {
> +		*dir_sticky = !dir_allow_nonowner_delete_child && dir_allow_child_owner_delete;
> +		if (*dir_sticky)
> +			eflags |= NFS4_ACL_DIR_STICKY;
>  	}
>  
>  	/*
> @@ -750,7 +958,7 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl *acl,
>  			default_acl_state.other = effective_acl_state.other;
>  	}
>  
> -	*pacl = posix_state_to_acl(&effective_acl_state, flags);
> +	*pacl = posix_state_to_acl(&effective_acl_state, flags | eflags);
>  	if (IS_ERR(*pacl)) {
>  		ret = PTR_ERR(*pacl);
>  		*pacl = NULL;
> @@ -776,19 +984,23 @@ static int nfs4_acl_nfsv4_to_posix(struct nfs4_acl *acl,
>  }
>  
>  __be32 nfsd4_acl_to_attr(enum nfs_ftype4 type, struct nfs4_acl *acl,
> -			 struct nfsd_attrs *attr)
> +			 struct nfsd_attrs *attr, int *dir_sticky)
>  {
>  	int host_error;
>  	unsigned int flags = 0;
>  
> -	if (!acl)
> +	if (!acl) {
> +		if (type == NF4DIR)
> +			*dir_sticky = -1;
>  		return nfs_ok;
> +	}
>  
>  	if (type == NF4DIR)
>  		flags = NFS4_ACL_DIR;
>  
>  	host_error = nfs4_acl_nfsv4_to_posix(acl, &attr->na_pacl,
> -					     &attr->na_dpacl, flags);
> +					     &attr->na_dpacl, dir_sticky,
> +					     flags);
>  	if (host_error == -EINVAL)
>  		return nfserr_attrnotsupp;
>  	else
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 0f67f4a7b8b2..56aeb745d108 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -259,7 +259,7 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		return nfserrno(host_err);
>  
>  	if (is_create_with_attrs(open))
> -		nfsd4_acl_to_attr(NF4REG, open->op_acl, &attrs);
> +		nfsd4_acl_to_attr(NF4REG, open->op_acl, &attrs, NULL);
>  
>  	inode_lock_nested(inode, I_MUTEX_PARENT);
>  
> @@ -791,6 +791,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	};
>  	struct svc_fh resfh;
>  	__be32 status;
> +	int dir_sticky;
>  	dev_t rdev;
>  
>  	fh_init(&resfh, NFS4_FHSIZE);
> @@ -804,7 +805,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	if (status)
>  		return status;
>  
> -	status = nfsd4_acl_to_attr(create->cr_type, create->cr_acl, &attrs);
> +	status = nfsd4_acl_to_attr(create->cr_type, create->cr_acl, &attrs, &dir_sticky);
>  	current->fs->umask = create->cr_umask;
>  	switch (create->cr_type) {
>  	case NF4LNK:
> @@ -848,6 +849,11 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  		break;
>  
>  	case NF4DIR:
> +		if (dir_sticky == 1) {
> +			/* Set directory sticky bit deduced from the ACL attr. */
> +			create->cr_iattr.ia_valid |= ATTR_MODE;
> +			create->cr_iattr.ia_mode |= S_ISVTX;
> +		}
>  		create->cr_iattr.ia_valid &= ~ATTR_SIZE;
>  		status = nfsd_create(rqstp, &cstate->current_fh,
>  				     create->cr_name, create->cr_namelen,
> @@ -1144,6 +1150,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  	struct inode *inode;
>  	__be32 status = nfs_ok;
>  	bool save_no_wcc;
> +	int dir_sticky;
>  	int err;
>  
>  	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
> @@ -1165,10 +1172,26 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>  
>  	inode = cstate->current_fh.fh_dentry->d_inode;
>  	status = nfsd4_acl_to_attr(S_ISDIR(inode->i_mode) ? NF4DIR : NF4REG,
> -				   setattr->sa_acl, &attrs);
> -
> +				   setattr->sa_acl, &attrs, &dir_sticky);
>  	if (status)
>  		goto out;
> +
> +	if (S_ISDIR(inode->i_mode) && dir_sticky != -1 && !!(inode->i_mode & S_ISVTX) != dir_sticky) {
> +		/*
> +		 * Set directory sticky bit deduced from the ACL attr.
> +		 * Do not clear sticky bit if it was explicitly set in MODE attr
> +		 * but was not deduced from ACL attr because clients can send
> +		 * both MODE and ACL attrs where sticky bit is only in MODE attr.
> +		 */
> +		if (!(attrs.na_iattr->ia_valid & ATTR_MODE))
> +			attrs.na_iattr->ia_mode = inode->i_mode;
> +		if (dir_sticky)
> +			attrs.na_iattr->ia_mode |= S_ISVTX;
> +		else if (!(attrs.na_iattr->ia_valid & ATTR_MODE))
> +			attrs.na_iattr->ia_mode &= ~S_ISVTX;
> +		attrs.na_iattr->ia_valid |= ATTR_MODE;
> +	}
> +
>  	save_no_wcc = cstate->current_fh.fh_no_wcc;
>  	cstate->current_fh.fh_no_wcc = true;
>  	status = nfsd_setattr(rqstp, &cstate->current_fh, &attrs, NULL);
> -- 
> 2.20.1
> 

Hi Pali -

Apologies for the delayed response.

Being somewhat un-expert in things ACL, I'm not sure if this is the
correct approach, or if it's right for the POSIX ACL-only
implementation we have in Linux. I'm going to research this a bit
and get back to you.

-- 
Chuck Lever

