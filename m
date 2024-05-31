Return-Path: <linux-nfs+bounces-3510-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41298D62D8
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 15:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404351F235BD
	for <lists+linux-nfs@lfdr.de>; Fri, 31 May 2024 13:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E543158A3F;
	Fri, 31 May 2024 13:21:09 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA613158A1D;
	Fri, 31 May 2024 13:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161669; cv=fail; b=nRPDI+MwfPEe2WHAoItw1iAAlYfniMcoOkVpjPBQjRnlshJDOTeMKtxJRHCIVUV4+BNcZFZh6ynPs/mkfe5VWJLV/yLph5BHLf86ada+EfDW/uW7SnJs3qLcdowKRZ+0D76Bv4EJQljelmmyBXEU+dZhFH7+oW6uoJkn46srDF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161669; c=relaxed/simple;
	bh=e5gs+9A58L+qwcKlqV+bRcuhQhGWXDE6aIw/mEuKARc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y0n7MKCDfM57bQWn8j/dGsvl/lVUkhLTIs6TbNSSRKbPM+zrnL2KY1rSIzltQW08L5CdYHzFJGaVGHA9WoRIeCgc1FgfTpqfdXpva+23Z2zqy/qsXFHFQ+50l7h5MQR0ZwUaN9BohOSrl4WKcKxPlEDEixjB1AzV83uNVL7KCDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44V9TALb025232;
	Fri, 31 May 2024 13:20:58 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3DR7A7ku6jADhD?=
 =?UTF-8?Q?844Zn2U1CijOAn+FfbxQvH/enzAK6bc=3D;_b=3DBglxdurDmzEndxn6SZKTVFu?=
 =?UTF-8?Q?kVBZZFQ8SHjWzXKC0sNRM9vFLUOAaIPsnOX5G0A6vNbSD_RQjt5ycktPtsXsENe?=
 =?UTF-8?Q?rD+2VuFZJG1i7PL4kj4B5XOgEmyW0MSub2q5jhqM2wKMEf404+D_3LbZ555Lfwr?=
 =?UTF-8?Q?hltlGC3ncYiuxIYuLWVHRisZsz6BcX0BRGvmrucLDa9KxLf+8/5mYGMNu_suIo5?=
 =?UTF-8?Q?ySPcW6m140KtKw/o1du0vLnsZWxk8f0+JjK4xLfEOtn1DUAlFzttactgKTgv9Sk?=
 =?UTF-8?Q?_7kGh8HrGapxAhPB5r5HvVxBqktWyYfMLMXcx2ThGs+oDW3FqA20DHM7PWgi6i4?=
 =?UTF-8?Q?XhCJm2_pg=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8j8b1nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 13:20:57 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44VD0j81024180;
	Fri, 31 May 2024 13:20:57 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc52f6n0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 13:20:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuJk8Hjdi4ZG6lAmRiDD8lHWNiytMyLi3bFITiVs2tqtefdtC4AvMF2vNm3Vx4S2sJbVqW8Q7W0Zhn1D2N8orAUSKQ1LKt3H8UMkG/RJzqPVp7tmt0J0JcE9jxTldJb6KVP1MDS4+0xOwH9nNNcM12ml2MbehVGgHC4Mh+Vf1M4X+v9fSIsgob0AHuCSILMrDp1UeoVn7dGr17ahQATR2GiZ9sff/FZyMt1nNMhZrw0LvOMFVuauYXJUabeLz2nV92dF7YAeQKq4f+s1HIjwXqHoVzqojDeDPeT0coHhwrIj8ZQ34Fq3hA+3lhNpRC9PNTUftecNsyiQk4+ZEDUnXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7A7ku6jADhD844Zn2U1CijOAn+FfbxQvH/enzAK6bc=;
 b=k6NQA9sN1ojxacrnxV2KKtLJLe+vo67g1mZOVp/B5OJI0W7ITeZgOM2tkKqJ/GFXH/quDNs2gaPyhEZ/wy2RV5M++hWG+W0XF3WDmGhLw5E5Dy6cI5AjUMQxImk+aCxhmnrTa8nJiVs/vOfy0HQPtFBpwycT91c7DCPLZa3ECiPOUivlnK6Z7fXWCMD09so7G46eV5HB1NsYzK+n2JuebOs8gIE9iXJGJTbs5VNlR+pEI1yx0PPSF4Js38NKxSh20AaXx+bKL+g6In3nmJAXnt/H5CrmK38h5v8Y/K6NRzOuJNjaR5Vb/2rsDPNWcg+983oBOjdQPiTFLK+R4pexZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7A7ku6jADhD844Zn2U1CijOAn+FfbxQvH/enzAK6bc=;
 b=MxctoVwjhyZ8PrL6N1mXR6HN+BKwPlUjnVYk7DeQGtBciJAJFiRMA7ZDta4OZkCj78iVEVDRIT0vo1VtWrAvFTJM86gT3zZ7/fB8qhiNvbzPRq+T0HRVl5B/Bg21AdaU8tfQH3WkvhNMS2JHm5Hh9dmuChtTWpOtnVlFdhKmUMc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH4PR10MB8123.namprd10.prod.outlook.com (2603:10b6:610:23f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Fri, 31 May
 2024 13:20:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.7611.025; Fri, 31 May 2024
 13:20:55 +0000
Date: Fri, 31 May 2024 09:20:52 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: "linux@treblig.org" <linux@treblig.org>
Cc: "jlayton@kernel.org" <jlayton@kernel.org>, "neilb@suse.de" <neilb@suse.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFSD: remove unused structs 'nfsd3_voidargs'
Message-ID: <ZlnOtPuCMc+82tdz@tissot.1015granger.net>
References: <20240531000838.332082-1-linux@treblig.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531000838.332082-1-linux@treblig.org>
X-ClientProxiedBy: CH0PR03CA0188.namprd03.prod.outlook.com
 (2603:10b6:610:e4::13) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH4PR10MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 76fbfa98-faad-4ee0-4bb8-08dc8174805c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?VHVNwT6PqKKsCf80Wcukq4Z+TR4dHibkZ4wa/0vxrWzf6efCYbGNxeGfQNFn?=
 =?us-ascii?Q?541gSP6uRqf9JdWpdwSpVKYI03+1sZWYyPgRtKAuNBOSL4Gl6RaKQvxS4gVK?=
 =?us-ascii?Q?IpILrh5/K7WfBKfIZFnVsfCyGwCUKhxfr3aIEBvVU+n/RqBQjNj83nptjFJM?=
 =?us-ascii?Q?2iQ1AUouGBg9qtukSzcI9CSk0zPa0yww1AdzPh345+T94XwiVjsIhU35/kZr?=
 =?us-ascii?Q?FWecXonUZG3vwhucsCvcxuLHmWPK+iClxWdpjxvcjBNrbrRiqX6b8EOeu3PN?=
 =?us-ascii?Q?T9r5u7XS1D51EcNLqzhIyzNz7Fzc6iiKZoGhcVhamfj24HG8kM7JWCC1B9AA?=
 =?us-ascii?Q?VuC8cpdE4QFAyjE5t5UDjYVQ1SkGr+0Go1rUFSP5Iv8CemVcxPvq4y8rrAH0?=
 =?us-ascii?Q?ZKx4pQFCc5M3msgl3oh1RYgtYr2JZ59uAcCTWcWevNQ42rd+HgZGutEMf/Me?=
 =?us-ascii?Q?GVm34QACggXCw7Z5jOEtBCNUzLpmfEkSwqZqO1ftjpcZo2Vu8zpwl69LLKtc?=
 =?us-ascii?Q?IOqtUI9Fz5MPowqKS29Aq3gGoPGDI2mJ0hVQxyyyHPlVC0Ru2NXCBT7Lw8fb?=
 =?us-ascii?Q?1IXJWkze+ZtZt5KZXQ6dV+hx1zK0b2baFjdYMZAeDZVkFJ2ISS0Ze2ayF6Ya?=
 =?us-ascii?Q?l9HJpmH9xIPcYK+OfGwiX3S4MiafOh5B9dTb4fWWHj7rGj401euPW3cmneNH?=
 =?us-ascii?Q?b/gWdtVO85rllB43gMbvJEFHoWHwUo5LnAbmTp0NEQCO9OhaV/inS5MKkXVl?=
 =?us-ascii?Q?VkBFhT9jrWdSa8TEy6yvHWK7GOR6wi3ttXL+VG8PeLtQKZ4LOql8F8XLKWG/?=
 =?us-ascii?Q?6O/xVs+PiipwUBuECRAwHKT1N2aEcOb+4DP+bFI9vKp8wfbBFMTjz7Nbl5qb?=
 =?us-ascii?Q?Mayn7CnpsCMer/rcCWvitjIFLCwj/itTmwp35VRxObMhDH5XE/Dv5V8rMqbx?=
 =?us-ascii?Q?ew8AGDZnKLcZZ80/iTUgSHJX9ODI0f3z1xmdJZnedYGxtglPl09BwlIbl+wo?=
 =?us-ascii?Q?9cKwvGVsxPxkjJP9C4BZdS2d3HLv++4uPzkPrEvt70dXm8IWsuA7fnsM+0De?=
 =?us-ascii?Q?ovEeK+1cNMdhHrXlXNEy1vJe6qlTdL0E7/7wE/bnPTXZtPfEIiR80L1hmqQO?=
 =?us-ascii?Q?WHBF/PwWYad9YgTqo9Tkg+aJ0pE7sByRSHow782gUTdnOMA4wDAIR/mh3k2t?=
 =?us-ascii?Q?wtctNKOnIGtQXjCLlRxiuKb+jlT8Q2UaN26iMna+WovK+OfUxxY0QClZExq2?=
 =?us-ascii?Q?kFjO+Z61G6OVZWzBbLhgv0k4AxkW+FT5Xj3gRkGtbw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?46n3AeiUtVybuZNA0OXgKVEHQw2oMqBMsrx9rxBTaeiYP6NT3XTbnqDqy5ji?=
 =?us-ascii?Q?zLeb5nnkbAD6vVnuFbaVCRYMCotPkd8kmO/+OjHxHLGPQrvetyJyROPf8KW7?=
 =?us-ascii?Q?POA3BW8xt3Vg5TDpyZQ1fIDeQ3/3IrSsx683CpBiQlW9ju7tPbkp7ghpOGa0?=
 =?us-ascii?Q?si/jAo2bAwnEpoB66AIwht02urvASf3w3ufDiPZQGFQ5jH329/N9NRg92TaY?=
 =?us-ascii?Q?D9yESvG9OH0FzHHeE8iH+5XutBH+vXqt09h+biuZR+fa3P+HIoGHVSHZ1Dwg?=
 =?us-ascii?Q?rdlkg7x2+u1rol2m84cj+y7erX1C7ZTHlryX7XsX+g/qb08GnWUIif2357L5?=
 =?us-ascii?Q?3lLOLqbArw7PpEa2af5DktK3gULigPqDviz16JLvg34I3eofcXw8NGgt57gS?=
 =?us-ascii?Q?ui/iMwbiKgXFHZvnUkqnUJfgkuVUTlwlBhKt6Ka+finFzGW3M5z/bhHcG3xK?=
 =?us-ascii?Q?Gv8j91SP+NYYQxTbKtJyexziOACjlAhjU/5R0Ju46r6CwKp7pM7EgxYyN31F?=
 =?us-ascii?Q?WGECIVGOND6q2ToraAJKfslmItRrCN4zcmTfTcL6fcliqTXtTIsBmyj0zwKK?=
 =?us-ascii?Q?HG84NE0x4Z6841yOsWMbb2yVnn03FXQRkxrpa1njfIYBN8iapjXaNgUsKxvS?=
 =?us-ascii?Q?R1cvz3Ey2Qv8K002Uwohoen3uJSAR8GMLo5+rbI3sJJBi96YDOnUZKgC/f9z?=
 =?us-ascii?Q?bKIdek19oUAcwrUjTOzgZvndtm/+0+hXcwfENtIdn/bj0MSxrgqnQBoJrJmE?=
 =?us-ascii?Q?RX99v83yps7uMpcWdk+KMCrRZ2V+YaolEOuFWplkE7Wnb00A3GMKU7GQtayr?=
 =?us-ascii?Q?t/UrahsZLFG275OWrU4BFbNbR00IouQTU/dIf+dCc6m04Mrk/pIaOc1zIwjQ?=
 =?us-ascii?Q?MOQNYt8EMn9W1xHAxUtfmaUaNl9Kxrs57P4Zvbwr5ErBDitdMbaDjiCnSyNh?=
 =?us-ascii?Q?QKiLqwVAYbrMaoZKmXw3MBnhIxTVoi4v0GjZAefMVO+B/H1qMYfYaRBQ7hGR?=
 =?us-ascii?Q?G4jXLu8o825wxdGKQ+dznsAMDYqLfKB/5Zp/879KbXt0hrEHrBxrdzXaagmI?=
 =?us-ascii?Q?MD6/uZAxoIEZHw7ofnkZ8lfOUkyq+qEuc5tbBJE20LvHOATBJjiEvs8Dzuu8?=
 =?us-ascii?Q?llDRjh1qxrlLBrZmioZhlbkRuteanbUnqe0djTD6OMx+UB5s32DmI5jPIxZh?=
 =?us-ascii?Q?62TIAlohx2oNCVvcRLCYjahwA4p8JWf9pbBy4Xh5AyKld1xl8WquqgRZ0jyu?=
 =?us-ascii?Q?6HvgxiAzMz3CGeFRVCZFXYUjbtuCS6E8K9x7SPmr9xxL3EW5gq6Df8zTnhJD?=
 =?us-ascii?Q?SQVQbZsWA6maHJr5m0vkPApQTJIE72QhLsQMXEBdYSUfUCUwPu/l5JANp0wo?=
 =?us-ascii?Q?Idw3iu0xlhVLE7dkVFAN3PXIMO01qQ502ZLJ4711Ji7M7r6yk5yWn11FmrEi?=
 =?us-ascii?Q?rGfUw/GiXZwaLsbaBrwdPpv2ejkNNnZ4mqE59ShumZLKfI0CSqJPRFf1rSyw?=
 =?us-ascii?Q?V5SEFYWYj2IlOMcy0bJ2OuJfRpUTtnoCYo5zeQMG9ciRcNXojNklDhDho16K?=
 =?us-ascii?Q?0OIen8p7rYHsK6MVHcatTyx2m8JYp7ohxdwXRJRmY7jUFf+ixjOtengVDo8S?=
 =?us-ascii?Q?8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cCOGKh1Q3nRpkUMERxvXJFjxIzQzv/2YhG2JloBfCvTSRCpOjpF4vAiNsuxXwcok7IHzS8qNZfs45/RulmWdpl4kJAe3r2Q13pP9aojMuMJiWyw7EK39r4zeYuMcwXCUoVi4SiruZJ3akVzJFfJvSs3RInYPNq/MXhsIW4Uu0PLuCiRn2jmOCO+lPGtdDASbAXh+pqqiNU8Jyh7lNkwHW2H5lePY6C3+6SCkeYURQ35Lz3KXlZm8aX8rgM2xSLEWNkQEiCqFFb/ZRoWGMJMtKuD6DkNm3lrI4PcnZfCZQPUJCl1OTum2IKehv5RsM3cOWhuJB1giCEWUVDgAvHd1YjOE9Pn0T5HZD+U1jB6xwhnznBkyc9HAcnmwRIrbFHFxmrzSQXRHgr0+Cpg+dq1U5r/rv+EUoczxDZt+Ug4S7Sas5XJc2gDknRWR6frs4VU5Z7Z/6dKgQRcf/x2BsasxYrDYu5vZjmt5JJU2PlzAYv4nQPb+WHcl1bh/d6R5HMV9SceIWN0wBX7SOw45Q27twPRfXFeRZqzcfvH4hIGxmiEmEudusx9oNYMWvUPAsXFyC9s1YhmojnRDNGbwdLdDubThQ7BcohmvJoHlnf6mqvY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76fbfa98-faad-4ee0-4bb8-08dc8174805c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 13:20:55.0816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFyFYlI/XS3//MQqnIE4cnCrt+KnCQm5yRVc+cuRi5VHMFHDgY5LqKspuUC09wJCdf6kYJrsiTIep9Q3KzgbIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8123
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_08,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405310099
X-Proofpoint-ORIG-GUID: 6zHR5SK1wjPu2NG01wIzn5IM66mt-Yld
X-Proofpoint-GUID: 6zHR5SK1wjPu2NG01wIzn5IM66mt-Yld

On Thu, May 30, 2024 at 08:08:38PM -0400, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'nfsd3_voidargs' in nfs[23]acl.c is unused since
> commit 788f7183fba8 ("NFSD: Add common helpers to decode void args and
> encode void results").
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  fs/nfsd/nfs2acl.c | 2 --
>  fs/nfsd/nfs3acl.c | 2 --
>  2 files changed, 4 deletions(-)
> 
> diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
> index 12b2b9bc07bf..4e3be7201b1c 100644
> --- a/fs/nfsd/nfs2acl.c
> +++ b/fs/nfsd/nfs2acl.c
> @@ -308,8 +308,6 @@ static void nfsaclsvc_release_access(struct svc_rqst *rqstp)
>  	fh_put(&resp->fh);
>  }
>  
> -struct nfsd3_voidargs { int dummy; };
> -
>  #define ST 1		/* status*/
>  #define AT 21		/* attributes */
>  #define pAT (1+AT)	/* post attributes - conditional */
> diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
> index 73adca47d373..5e34e98db969 100644
> --- a/fs/nfsd/nfs3acl.c
> +++ b/fs/nfsd/nfs3acl.c
> @@ -221,8 +221,6 @@ static void nfs3svc_release_getacl(struct svc_rqst *rqstp)
>  	posix_acl_release(resp->acl_default);
>  }
>  
> -struct nfsd3_voidargs { int dummy; };
> -
>  #define ST 1		/* status*/
>  #define AT 21		/* attributes */
>  #define pAT (1+AT)	/* post attributes - conditional */
> -- 
> 2.45.1
> 

Applied to nfsd-next (for v6.11). Thank you!

-- 
Chuck Lever

