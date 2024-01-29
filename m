Return-Path: <linux-nfs+bounces-1568-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8078840C8C
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 17:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08D231C22FDA
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 16:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBD115699F;
	Mon, 29 Jan 2024 16:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ed3UbYT2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b+tJaZne"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC30155A50;
	Mon, 29 Jan 2024 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706547358; cv=fail; b=jmqXylHqBh6IIAAA/CEm7C4CU55dgf1xrgWID0gwbzDJ3Cbn0JVosvQi8Pf4sb2VYnP8115cL7jqwuwbWlqP3bZptbJgtQk0WQkMPSKcS65gQhYYf8JI0QnkIVlYaj1yynHVkaWujydgmoV8wx9H9V3p6Kaq2uu/2obePdCQ++4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706547358; c=relaxed/simple;
	bh=HYVMR2uWumYw0OYhmCzHmwEfmPIjlt8xkl4kbaFOCfI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sAMJ/X4ycbfU5cUjRd9k68pKxRUgfWAQxOZ0mEA0fB2IWMZ1b+tcWKICxruM0QkBWpq2gZwwfaaDxNnjNW71u29ZyNbL3HLYuawM3c5h0gdkPCGYtKNfgKf7Bv6WZLJF7U1Ww4L7VOdpjqKO87Uezd3TrtCFpaS/9SlBItu431Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ed3UbYT2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b+tJaZne; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TGnTYG027480;
	Mon, 29 Jan 2024 16:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=HYVMR2uWumYw0OYhmCzHmwEfmPIjlt8xkl4kbaFOCfI=;
 b=ed3UbYT23vkthUO7nBJyMCD6L+nU1AFOEkzTT8nnntqquYC6hMgcONXAcGttzeKivwpu
 9FgUYESmuzj+IQFzBHFhHTj78vkYKwhBaetuZHKVReRFSfYDFTZdYSCPmIOGAVJqNICj
 mKSEXjhSJSyfkSan4hG8+tpzPgjE7LkP8WQ4yZ9BE8k+0B39TpQiWUzw9A1G1rUpmFkw
 iL/ZLPyIzupIKU5g/rKL78+MPs0NyEv/brKgwuBEw55sDx0wbZuW8ugeDMXMSGI9kxHn
 is663UHgnm2idw6++4Ct4xmsUb8I2rmoG+Oh1P6nzAjysAanURxPz7drrq572zKOMh49 Ww== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvtcuvcc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 16:55:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40TG6SRF014626;
	Mon, 29 Jan 2024 16:55:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr95w3vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 16:55:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVusi1plY34wgkX/nM5dkp86vZJJi9TveSjie1wd65NtQ3L3c3ka/D1ZwJHmil57LS9Q8IY2sbq/loVkfKTG9cFZHLLmyFFMZPXHfgah+IN0fySVqDphWO81XtKxhBulrQKit4QZMKAL+Yjoe49l8b5ZAQvGdpkrG8WC0f40N7eEX1f5YfKsn+K15Ro9TdWLKAtpnuzorWcZACCceSJCximaFGwyWmwU9uqAGLgsFscPFPxWcV5razXEuVzuUr8ruRhbpLkEVeKwyYEri4R7b7qXX46NlaYM2uMT1Itb6K9VuMgaNHZpNVhOA2AZyTM81wNTghkf6h8tOcCR/6SXSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYVMR2uWumYw0OYhmCzHmwEfmPIjlt8xkl4kbaFOCfI=;
 b=gMUIOP6RnxWpwogA8YpiNA0bggNPtIjCUSu4mfVBumhksvq6PAdRpot7398Z6odUPKUPz7Byi25RQCYeKfGueWEVQgWZSUjjuhLd4jc01qjyeDiF9beuYJmv8LYdtF8VEHfV22fPVKqMGlH31dBu06XhW/AsOwujhXRlSK7MBEyRQmvoYqSXYzOMaQ0I+kbiasJBmj+2BU53Rt9Ra7L+0d7WdpPxoSk+fiEo0C0+wYnYySj7jqIv2Ci14UMx7rGbEtn7ayKq0PoGPUvaEMwUO9YHwJNwo+4LeTraX/6au6P0fk2aweVnT265UXsuNEIstHgXhFNn8M8Fi6x8JskipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYVMR2uWumYw0OYhmCzHmwEfmPIjlt8xkl4kbaFOCfI=;
 b=b+tJaZnehdISzVFIFVAhDx37LfBq71t6lA4zkCzsIw+4GsORxKUFifBqlCujbeBaxIfm3zHPrFnWpzsG9Rjg7KMnTE7uYidQjbOr/1sqTNGxcV3eFxl0apg8gXYdTuKrSgE0C/iwAH26p2Sb/2sj8dMALy61HNUwP8JjstPzo5w=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 16:55:33 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%6]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 16:55:33 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Benjamin Coddington <bcodding@redhat.com>
CC: Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga
 Kornievskaia <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey
	<tom@talpey.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna
 Schumaker <anna@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Linux NFS
 Mailing List <linux-nfs@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Alexander Aring <aahringo@redhat.com>
Subject: Re: [PATCH] sunrpc: fix assignment of to_retries in svc_process_bc
Thread-Topic: [PATCH] sunrpc: fix assignment of to_retries in svc_process_bc
Thread-Index: AQHaUtJM1QSrjYxmB0ONPOC4M70BBbDxAXoAgAAAxgA=
Date: Mon, 29 Jan 2024 16:55:32 +0000
Message-ID: <C4D894E0-F9C9-4C31-BA49-05E942FE0A6A@oracle.com>
References: <20240129-nfsd-fixes-v1-1-49a3a45bd750@kernel.org>
 <7E6930D1-14BC-4CBC-9833-531BF6F5D874@redhat.com>
In-Reply-To: <7E6930D1-14BC-4CBC-9833-531BF6F5D874@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB5009:EE_
x-ms-office365-filtering-correlation-id: af026b55-679c-427b-5155-08dc20eb1b79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 7STp8qm3+CcZ5wp3HSAmD/lcABqAey1PGer16f9g4AZ5m19Nvj3AqF+88wn9YdNvkIxSObvJ5QodVqS+PT/gG2S6LaIyzK4BlPhBalIaInnINbyoYetBNZCUSSL89/Uc+/Tgr45m1LGy2RCBkMXHEtSkuMmmzGyBX0kDGGcu7cJ0HUS6aw3wd1JiugCQgBpCCFkfE++3cgJ35T2n2KMnSItVjRp6IVp4/+Mncf19q44u0RXCzUSv+rkHw0PLUzN6sh5F2eRxv+cHDBPb4lSiArLpgqc6jlN2jE+6JwKEjesoW4Br+H75H5yUJcGo4Q+3MtQdyXhf9wD3Cnd3uoHsXqijjNYZ4sR5nUvXwzkGdnUPeZPKJ2YSc1b5roNmLgZscKSdwDaSJRup9Q/NLGFVR2IVc8G7qvncvlbrT6d55+/LcT2nKeIEkoHtihVqEgeIz93j6aAjXsnITul96o0py0tzkCrk8j9z50P+40avCbuvKoOPRSK6lpxeOasOT7eHdxu3u6DTko+Ug8uPHTK5V+3tt235ZaC/tCpYJjvOhqTd5PtGZL3ug2DpNVbdr6Ml68/PD27nQfl5YrqaTm6PRuF00yWEB4WIwFgeIiP4WDB8f5M+DC4LVebuTl3BIFpy4pP15dY78RdCIc1u9JVMRg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(53546011)(6512007)(6506007)(26005)(33656002)(36756003)(86362001)(38070700009)(5660300002)(71200400001)(41300700001)(8936002)(8676002)(4326008)(38100700002)(2616005)(122000001)(66476007)(54906003)(66556008)(6916009)(316002)(66446008)(64756008)(7416002)(6486002)(966005)(478600001)(4744005)(66946007)(2906002)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?K0x6eHZheWtBekJhNnZoWU1uUzgzNlpBL2YzT295dGo2cy9jUDYweWF1YWlK?=
 =?utf-8?B?R3oxdmRKaGtZMVJVTVJ5ekZaT2R0UlRseWFhdkExZmtmZGFsV2I5dzlKc1FJ?=
 =?utf-8?B?T1VKcFBZVzVROERodnpVWGJlUTYrdldUVnlYalgxQUdoaG1GM1IyWDVBcWMx?=
 =?utf-8?B?VGU1OWpjdUNKcVhSbjZNWUZKVHg1MWJqQWZVdnF6RW5PUnptN0lyTlJ4Z3JM?=
 =?utf-8?B?UC9uMlNsaGM3TENYZndnQzQybnc4SkZJbFRTbmFXVFpPR3RyT2RSSjR2eDRV?=
 =?utf-8?B?UkgrUXRON1EyU3E5UDQ0VE4vdEhQeWI4SkZDK0M3SGc3cDVDTUFLYWViYVpR?=
 =?utf-8?B?dGRCSDBYMGxVZkxWdENtOG12elc5N0dEaVlOclBaamw1cEN6bkJyTmJVbmti?=
 =?utf-8?B?S1lDZ1hiY1RQa3NOTVpidFVqUnIybmc2TlRnNDJ2eDVOTGx3UGFaZUkzUEZi?=
 =?utf-8?B?RC9lYVM1NjM4UzdWVHZYVzFxOGtjWXEzRFBIemwxY2hYMmN4R2NjaG50YXhG?=
 =?utf-8?B?a2daQ3ltTjJIcU1TMWZiZjYzUjQ1dVZlRkJhcXRSSWUzU0pRSWd6ZU9PR1hF?=
 =?utf-8?B?MnB1aDB1Vk8zZ3Qzb1B3aW1rZVFBMHlnZ1hoaFNtaVh1NyszMklCVTI4R1hI?=
 =?utf-8?B?MTVkb0lVclJrcFdrQmc0bFhPcU9nN09aa1pua3RzNjNldFViTlM2U3VJbUFV?=
 =?utf-8?B?SllpcjloNWVWT1l5c2JTRmFDL1UxcDNaRStyZ0J2eFpjYmpycTBxWmxSMVpJ?=
 =?utf-8?B?NGhqT2tmbjVKTU5sL3RrWmVsN0Urai9lZ3dlcS9WNjAwWmFRSGEzam13WW4v?=
 =?utf-8?B?ZncrVktKU3o1YStSSWVjM1I3aENhRGd0QTFaTERDb24wUUl5S29iS2hqMEYw?=
 =?utf-8?B?N1RSZXNURVhRdU9icy9QUHdpMWNrTUtmNW5GNkJlZzM1V3ZWSDVzUTFucis0?=
 =?utf-8?B?NWVsSDVEY29nMTdnbWx0dTNBVEdrVmVRRDBkNHM1UUFPaEo5YTU4eWVPcVdI?=
 =?utf-8?B?eExGTDVBMGpTR0s1c2QyNVc4VGdmeksvTWVTWHFxTjZ3ajNvanlqN3J0b0hO?=
 =?utf-8?B?RmdIeGlRbkRGa3NVZlpSeHZnSWhpclhONlQ1R1VRWTVGZUpvZUxxY0E4TWo4?=
 =?utf-8?B?Ync0RFVWUDlIZ3pWb1BpZ2FjNE1wakc2dDRtdWlrN3NSenB0Tmh4ZHBEakEr?=
 =?utf-8?B?VHQrUVNZUWU0K0ZMR283M3NjSzFvNDJLTEhmTXdkWXZLbnhzSlFWdXhyeUMz?=
 =?utf-8?B?ZlYxRW1xTkVYMk5ER2NKYytDWkZtNEJ2ajJhSkNvKzNXeWJXV0JDeWtaWElL?=
 =?utf-8?B?d1hmN3h6akx6cVpyY2VtMXZFd0JoNGZJOUhNUmw3NkN0czN5ZUVwdm1VSVlB?=
 =?utf-8?B?RDVtNStYZ0g2KzVQS3pGKzZnWVZuc2h3Zm1IKzZvU01OWEFlWTJROGZ2N3dI?=
 =?utf-8?B?bTVNb204SnJBcHMrSVN0UCtvRE0ycEJSOHpzNlo3Z09Ld2xOU2lXWHNUS1R6?=
 =?utf-8?B?SjFHdFUxT1VDT3NaMFZCY2EwdVlVMXA4cTdtSkEwaDYwbSs0VjFqWi9FbExN?=
 =?utf-8?B?Z1BVUi8xYko4Ky8vTm5iY2VGNHN2QWNGbkxhRVBWUjNKcFIxUS9zb1NGTEpW?=
 =?utf-8?B?V0RiNTZ2Y2ZsbkUzbytqVzFseFVPejVDNEplTW01b2R0ODlLbVJRbVYzaTJx?=
 =?utf-8?B?d3FZdmVKRWUxSThmY1B5UnQvL1VmdjFTSFFGTVJ2bzBBVk1xK2FJVUFOeER0?=
 =?utf-8?B?c2hCQTVCcnlDYjEyTzg4UFFiSTdSaC91WWpwLzN3dDAva3d0elR0QSthZXRh?=
 =?utf-8?B?dzF5R3c4Y1orTUpib3dKUmNTSy80RzZzSXBrVEtaSXpCYmpmUTBHQnFPcFVF?=
 =?utf-8?B?MGdhY0JLVXhJbUoxRjdHYnlabWVaYURyTnRNR2hjOWpCemNiNzUvNVNHcGJw?=
 =?utf-8?B?VUNLL0tBTC9qSmxyL1JBemROeTJnZTIwRkJwWDlRSmt4dk0rSUZ1ZGxXQ2hP?=
 =?utf-8?B?RUtxTld2cG9pWENXTmYyWEd6UHNYeGc1VFFUeXdFK3ZvdE1sSENPclU0cS9I?=
 =?utf-8?B?MEJyRm1GWkx0MDRIYktJSzVPYlBTdldRK0p2MTFsWTFWb1RlNzdWVFdVeElj?=
 =?utf-8?B?TzNxbXBBUWRJZWpyWFptUFdsbTRVeU4xSnJzaDJsUDdYeHZZcmRyeC93Q0dI?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF7A2D664780B740BA0B3B0DBAD9D809@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QsIjDk/Kc9Ys3PZqDYqROVb0zw+mySHAgpfxdT7fRtAsoWi9enzkHJeGtPZkXIp+EkUgE5Nri9n9Un8481Dx1UBhiENqNSzctHsGhHOC2D37YjPOW15YSOlWkZOprkIdZrYhcO7poNP0BKu70KIhVXhR1pyLB1JYmEE9WQJCgMXtBVPXhYJ661GuScb3OnrZ6BdCxfVTqKbitJO66gxq4qv0B0JSTKaiZdN0pGQ36c+4uYdv9GecnRFT/Z8E4AvU+VDC/b8AclhXM4o4pCFuraaTQv7tajNjBAweWWtuTKVliLLOA12Z8WeHFC1wgmq42K4ZGok6xr7YmECCTEDuIHJU1TqnCN0xMCvnvk2AZhZOxRGiSmBnRC4y6lDiS4CJ/D1TNgvKmcwFbGHbVrrMsIv7Pyy1mYeVC6uC3gAF9H60z3zt0gHnzI04fX+Fdo1wdk0UDuCOojczU/2BnIl0djKa4NUTn9+s2N5AW7GO8GWlhUqgqm47V44agNF3HksTiXRM+FNhAxPRq9hKmGcZ33JbgPGyRv54YWJeV/WnKgjLQa3CL4wCr43IF9ixRdSUHxrXzl4MkQdHH6Cdy8l5X5uvftER0oMHrS6rlcUmQRI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af026b55-679c-427b-5155-08dc20eb1b79
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 16:55:32.9861
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8nYKhlybEsiQ0OXJUTTWlbqVqLKHry64Gbb17ejBCijVMmkcdOX6OT8u2s+uot2oUuSBkBKcutS7K455vWJSAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5009
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_10,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290124
X-Proofpoint-ORIG-GUID: F2jPnQxP7kORBG5dzY9nurIE0VDx2E-H
X-Proofpoint-GUID: F2jPnQxP7kORBG5dzY9nurIE0VDx2E-H

DQoNCj4gT24gSmFuIDI5LCAyMDI0LCBhdCAxMTo1MuKAr0FNLCBCZW5qYW1pbiBDb2RkaW5ndG9u
IDxiY29kZGluZ0ByZWRoYXQuY29tPiB3cm90ZToNCj4gDQo+IE9uIDI5IEphbiAyMDI0LCBhdCAx
MTo0MywgSmVmZiBMYXl0b24gd3JvdGU6DQo+IA0KPj4gQWxleCByZXBvcnRlZCBzZWVpbmcgdGhp
czoNCj4+IA0KPj4gICAgWyAgIDE4LjIzODI2Nl0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0t
LS0tLS0tLS0tDQo+PiAuLi4NCj4gDQo+IFRoaXMgb25lIGdvdCBmaXhlZCBhbHJlYWR5LCBqdXN0
IHdhaXRpbmcgZm9yIGEgbWFpbnRhaW5lciB0byBzZW5kIGl0IGFsb25nOg0KPiANCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbmZzLzIwMjQwMTIzMDUzNTA5LjM1OTI2NTMtMS1zYW1h
c3RoLm5vcndheS5hbmFuZGFAb3JhY2xlLmNvbS8NCg0KQWguIFRoYXQgdG91Y2hlcyBuZXQvc3Vu
cnBjL3N2Yy5jLCBidXQgaXQgd2FzIHNlbnQgdG8gdGhlIGNsaWVudCBtYWludGFpbmVycy4NCg0K
RG8geW91IHdhbnQgbWUgdG8gdGFrZSBpdCB0aHJvdWdoIHRoZSBuZnNkIHRyZWU/DQoNCg0KLS0N
CkNodWNrIExldmVyDQoNCg0K

