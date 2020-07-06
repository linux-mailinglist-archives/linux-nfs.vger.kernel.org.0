Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC924215FDE
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2020 22:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgGFUFE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jul 2020 16:05:04 -0400
Received: from esa10.utexas.iphmx.com ([216.71.150.156]:56974 "EHLO
        esa10.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGFUFD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jul 2020 16:05:03 -0400
X-Greylist: delayed 425 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Jul 2020 16:05:02 EDT
IronPort-SDR: QtUA1UfYcyZ4tt6/+OdcuUfemqxMk3sYYVfAOqOyDTv6q9RaXB81f0/N2U9HbNK6Npb6CPDDWy
 XFhVCGlMh1x+id+BBLf6NppAKRUOQI25kIKJH6MQRRhNdswDURukWz3MFO8QOTswHfWiUcHLiT
 dgbVIClrVXKsI5i1yT2X+UoyOVPpH06Gj3lE8AzIifh7fn7CHOsu/ia6n9nNTzkkfVIMa4z0Kl
 VzUNV8/yGLoIsoEpltoYM5BcFp1N9CVe9pLco0Do7aLQhKKZh6wImZ5QK2f4Oq4z8c/ltNzAv/
 zro=
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 215980970
IronPort-PHdr: =?us-ascii?q?9a23=3A5Xgxlh/AHCGjYv9uRHGN82YQeigqvan1NQcJ65?=
 =?us-ascii?q?0hzqhDabmn44+7ZxCN+/pglhnKUJ/d5vYCjPDZ4OjsWm0FtJCGtn1KMJlBTA?=
 =?us-ascii?q?QMhshemQs8SNWEBkv2IL+PDWQ6Ec1OWUUj8yS9Nk5YS9jxakeUoXCo6zMWXB?=
 =?us-ascii?q?LlOlk9KuH8AIWHicOx2qi78IHSZAMdgj27bNYQZBW7pAncrI8Ym4xnf6M41h?=
 =?us-ascii?q?uPv2dFa+1Ng25kOAGe?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FLAQApgQNfh7E3L2hgHAEBAQEBAQc?=
 =?us-ascii?q?BARIBAQQEAQFAgUqBUlGCKQqEKINHAQGFOIgTmFqCUgNVAgkBAQEBAQEBAQE?=
 =?us-ascii?q?GAi0CBAEBAoRFAjWBciU4EwIDAQEBAwIFAQEGAQEBAQEBBQQCAhABAQEIDQk?=
 =?us-ascii?q?IKYUpOQyDUYECAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQE?=
 =?us-ascii?q?BBQKBDD4BAQEDEhEVCAEBNwEPCxgCAiYCAjIlBg0IAQEegwSCTAMuAZxEAYE?=
 =?us-ascii?q?oPgIjAT8BAQuBBSmIYAEBdYEygwEBAQWCSYJFGEEJDYE3CQkBgQQqgmmKG4F?=
 =?us-ascii?q?BP4E4D4JaPodTgmCaOE6aCIJmmT4FBwMdgmEBjjyNf4I9hQuocQIEAgQFAg4?=
 =?us-ascii?q?BAQWBaoF5MxoIHRODJFAXAg2OHgwOCRSDOop0VjcCBggBAQMJfI52AYEQAQE?=
X-IPAS-Result: =?us-ascii?q?A2FLAQApgQNfh7E3L2hgHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UqBUlGCKQqEKINHAQGFOIgTmFqCUgNVAgkBAQEBAQEBAQEGAi0CBAEBAoRFA?=
 =?us-ascii?q?jWBciU4EwIDAQEBAwIFAQEGAQEBAQEBBQQCAhABAQEIDQkIKYUpOQyDUYECA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQKBDD4BAQEDE?=
 =?us-ascii?q?hEVCAEBNwEPCxgCAiYCAjIlBg0IAQEegwSCTAMuAZxEAYEoPgIjAT8BAQuBB?=
 =?us-ascii?q?SmIYAEBdYEygwEBAQWCSYJFGEEJDYE3CQkBgQQqgmmKG4FBP4E4D4JaPodTg?=
 =?us-ascii?q?mCaOE6aCIJmmT4FBwMdgmEBjjyNf4I9hQuocQIEAgQFAg4BAQWBaoF5MxoIH?=
 =?us-ascii?q?RODJFAXAg2OHgwOCRSDOop0VjcCBggBAQMJfI52AYEQAQE?=
X-IronPort-AV: E=Sophos;i="5.75,321,1589259600"; 
   d="scan'208";a="215980970"
X-Utexas-Seen-Outbound: true
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by esa10.utexas.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 14:57:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfHv9H+lq/YKCT4iOvC9mEVWBpU/sTFljfCV9Uo1MI5lKwMej3w7NKJaNje9im/NdsFl/B/INQpwXz9cw2Bg8Nh7YWNtkbvbfAq3Lmtxo6XwzML9mBXt+YLHttEARXCBO0a0SqozBCArqpHjgd4X5RuAaEeFTQD7J6vWPz7l6YajdMqm8eSdacMC03k/PH7i8FDpEYkMa8vmMQObJjR20pHMrctbPJct/NfMufvWOSvuvdUON3P6r5XuLK4bxTtFKRNgTpu0YUxjV0Mt/SbNrjm2dc1jVqz75BG2DsxjylJ8ca1AYvOJY1LHA9J296UolcFsqw1XsAMb1rD/uTHRrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0lUA2vFq85hqkKp65Ayy2s3MW1Uhrglzw1AA1hxkw0=;
 b=Rfs0kj6SYZ1S/wkvh6UiA6FBBNRMce46lJ4T1KWP5EiDNG0Pr/0Y5mXAkjyoq9sJSvJH0Ll33va9Tk7JYl4nCsEfdDSVr9O8FXie27abF0Q62xGSH9jfy7nDfB3rClpWFR7bKrfBWdfFHKKQGG4hzwVgjq5C7Gr7/AHIRFfO56MZTKdLRJUJB/I+vfaL6E5070fxRQe32orBCLrbqxlrP+t4qEBrYa4dFNJAsjpJdYzFLXXt0+MEVzbGOHnS+nEaPnzZHGPmsP/N2CB3hRDGOj7y1AbcCecRLTF1TqbbaAPnXKxGONBGlTDycAKttk1CxmhBhM1TM7Nwc8iAAJgVZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=math.utexas.edu; dmarc=pass action=none
 header.from=math.utexas.edu; dkim=pass header.d=math.utexas.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0lUA2vFq85hqkKp65Ayy2s3MW1Uhrglzw1AA1hxkw0=;
 b=a7yaa2dwbfJkeMRgbiIcBIk7f9ZlOd4cQN2wpegX+UV5EkaAjAHosrp/+l+8V3zTrgu37eV4SZtIwalQSyE80KiUewIsRtWJsbC4AqXMOH1PfZaTf3gsr0nSZ8//LYhDC+0HtJp6V1Gg19/QvZMVKS/Psz56tM9xxG5VHspqlrI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=math.utexas.edu;
Received: from BYAPR06MB3848.namprd06.prod.outlook.com (2603:10b6:a02:8c::15)
 by BYAPR06MB5765.namprd06.prod.outlook.com (2603:10b6:a03:157::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Mon, 6 Jul
 2020 19:57:54 +0000
Received: from BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::8570:7340:3a13:1f87]) by BYAPR06MB3848.namprd06.prod.outlook.com
 ([fe80::8570:7340:3a13:1f87%3]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 19:57:54 +0000
Subject: Re: kerberized NFSv4 client reporting operation not permitted when
 mounting with sec=sys
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
References: <0593b4af8ca3fafbec59655bbb39d2b4@kngnt.org>
 <9e25861022acb796c35d3adb392bf4c4@kngnt.org>
 <c058f370-9f7c-146d-e7e6-a3f88b62cbc4@oracle.com>
 <4097833.BOCuNxM56l@polaris> <20200706171804.GA31789@fieldses.org>
From:   Patrick Goetz <pgoetz@math.utexas.edu>
Message-ID: <4fe2af1f-917e-c1e4-f5e6-05eb0c121511@math.utexas.edu>
Date:   Mon, 6 Jul 2020 14:57:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200706171804.GA31789@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0201CA0003.namprd02.prod.outlook.com
 (2603:10b6:803:2b::13) To BYAPR06MB3848.namprd06.prod.outlook.com
 (2603:10b6:a02:8c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.4] (67.198.113.142) by SN4PR0201CA0003.namprd02.prod.outlook.com (2603:10b6:803:2b::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend Transport; Mon, 6 Jul 2020 19:57:54 +0000
X-Originating-IP: [67.198.113.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cc1bc97-266b-4c2d-7707-08d821e6df52
X-MS-TrafficTypeDiagnostic: BYAPR06MB5765:
X-Microsoft-Antispam-PRVS: <BYAPR06MB576540F3F9D7B3EAE1DA646283690@BYAPR06MB5765.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gt4CJLgpgareJp2dc1yw1PB3yEs11fLUJdzzlzmnw7oLS7EZQfqnMtvIe6ySOjY07Xs7sheaeHIpJJak9E8PptZ8PkfOKpXPWwdK0OiXAEHvXFunH2CtnavvwyRjw4UV8FwkOl0sQI7IpXT7+ol+dKk2LAM4gF1KJMLT/VNrYaRPUKWbbJF9M+Huok8PXdmluGektnSIKkBRo9eeL0aSZo6E02e4BKO1Q8d9NWRDHdNBR9cK8YB7mZIwvh9wH7QLfp/lm2ruA92qiKloMV2HT/FPdmgpw1SJXxrw9v/TQrUiinf6Coai/tjoB9gix9/OURMRkNxalPdYWWzWf5KZsfXXugT1bT/GQW/2wMtVXHAp9AfV+WLRc0zDpJLUwJWF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR06MB3848.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(316002)(786003)(16526019)(4744005)(186003)(8936002)(4326008)(52116002)(26005)(53546011)(86362001)(66946007)(66556008)(66476007)(31696002)(478600001)(5660300002)(75432002)(6486002)(31686004)(16576012)(2616005)(956004)(8676002)(2906002)(6916009)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: kyxGtLutSEtJPh1ptXU8+8O/2YJxSkoEnq8IQJvvznL2fdAOxyWz94PaMqW7fbHFXkhWAl/9gFWSwWLBTe+MGzSgxfqj8Mid/6mjf04m+I5K8wk0wL1KTdbvFJxRGn0JzOMTThZ43Z3U3519MxqewkghxzPSRjEbM9WLRbb854LFiEiFcUMaEXZGgGiua0E8pHMcosFJknMrRUgDgZNUfpNB2569HIJg5dR2btTjEv1XM53YTc/oiH7QqZGfn4x+hA1lETVaBpdzGJ/L3v3z30xUKNadS+5fxzpkMtLu6DFpj9jg/WTLCsda3j3pubWZpZm+qfqvh4gThwoNAiYdZP7A4Fvyt0x5fzpc1MH1HAwW46u1OyQzODCppWRJVAySg7PPkhmff1YYxep7m4JhvQJ2FHnog7FeKT5draeYunnvQzgV9QkrPiAIazdJUIdHVVyE/I2cH6/Ct50p1D7MLeFMgk78mqQwhlOFHKJEIRs=
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cc1bc97-266b-4c2d-7707-08d821e6df52
X-MS-Exchange-CrossTenant-AuthSource: BYAPR06MB3848.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 19:57:54.7492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sFd9wJnP9Lo1SRFIUnm2Ew5kck3SqZ/Ir1660OgELk9LPDnJ3hpgVD4/wa5xmPiyRZqiG8De0kPuHpnjq2Xig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR06MB5765
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 7/6/20 12:18 PM, J. Bruce Fields wrote:
> 
> Note, by the way, that fsid=0 thing was required for nfsv4 exports years
> ago, but no longer is.  It's usually better not to bother with that.
> 


Are we ever going to get some solid up-to-date NFSv4/pNFS documentation? 
  I'm sufficiently frustrated to write it myself, but am not 100% sure 
where to start.


