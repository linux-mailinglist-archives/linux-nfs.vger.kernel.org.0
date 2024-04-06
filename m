Return-Path: <linux-nfs+bounces-2692-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 086E489AC10
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Apr 2024 18:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E2F1F21861
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Apr 2024 16:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972443839D;
	Sat,  6 Apr 2024 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jgFwh7/+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mFNZbCAr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0DE23767;
	Sat,  6 Apr 2024 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712421447; cv=fail; b=h+7aBF9dOlRpTq+y+O+Wsb0YddICWV/fAYoZ3e0Q1me0owqjt7hp7cylVjnRKPhI+0iPZEcni8gtGZgOqwUnNIOTS1Obnjodh6tMsmnmHoRiBQGzVvCF168PlDylT4+sATkE4yuhqSkMZIs2uvd1A8AQQIvEN0D1ZfLt7MV5fPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712421447; c=relaxed/simple;
	bh=IX3I6XEwwOT33s7CIzQZmOLVcr2h0NWp/r+QgRikhUs=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=KB+1rGJpHQaK8KP3rmjdkqPBteMhMdnPDlBrj7qZ0cixqYnBDVZ1yxLB+LDZtb4hxMxqzsnm0ENJciSaMW/sVYZLePL4IVfaac/aHQZuCI5oui5MfcmpasWAI3aDMhlLmZgx84izIIZ+QZ0jOQyJ2qbhIT/nf0mrF4iRAseMyk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jgFwh7/+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mFNZbCAr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4363lvcr023744;
	Sat, 6 Apr 2024 16:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2023-11-20;
 bh=31cwNY0U7Oo2zXlHykqWOFL7mkc6HFqgAcXUI78AbMw=;
 b=jgFwh7/+IolGMWKT+yaDkMbJGDZb+lr1mljv1mD3VVIB+7tD5FhqH1zqdCuIJ3wAvdB8
 VXuISNlPbHhUsOBPRF9Kcj81ZCfVugehqZJFqkkGjuBpkvaLNzyIXF+yzLSEfvSb7ZvC
 o/AmP8xRXTwNAog4M5FdXo2Ee4Kde6gYjniyzTaI3eMIp3JOfGwIJ6Q9RLm9vbXX70W9
 no7db4fC9ZRYBPFDAxEIAQOhsZgnwzjka7fY+MrQBFYHHYURgaZdDxRs/I8aQ2FbYt94
 p71FeDXl4fEYWXqGiAY3hunh99VgR0iu/EiCBmfNcQ5ZPYhnqAPw0MwlHl0PP2BsoFhP Vg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xaxedgf2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Apr 2024 16:37:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 436DaU6O032370;
	Sat, 6 Apr 2024 16:37:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu482r0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 06 Apr 2024 16:37:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mECHVFuvaCs6JoVNDjyy3a1Awgfs2LdwIySgHb+UA7y8P70z8e8Nuvj3etrvD4hJRuh7K45V9XAU6N7ISjRAIM6/YJjhk+4OqGNSRmciFHxTle9ImXAhfP2URPDzOyQOtryQ77LQ0xhfmG8ZUykiRyFYe+wrfIhcSCOUilkvNlZ+ZHk4+x/J2fUuBiTLECRTLMASEeKk67GE2lJtD+VShGUffhMfov4hWCF+l9RuCd/TZBrhWorYigvtXtRJdahjGL4wPSzKkbghvlqAgkWRpRgDsN+xm+gVQsHQmLp5lLLt99yE9qRlx4rN9RaUDdAKBvFZFNLxoJCTwsJhQMwmxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31cwNY0U7Oo2zXlHykqWOFL7mkc6HFqgAcXUI78AbMw=;
 b=E4HhSL32NO7HZrm26/eNlVOVv+3hmKyTi/nG/FL61a37ab02eKizfeca7+D2rImT2sjehElQrR7L+vyA6lEDQ1VJj5EoOaP6EXgpbP4v18Yha0DylmT+ZBHGBd2+v/+PKVsvOev6PBQ4zKyvU6RtbQSqa43kDRHs+KlUXzZzo917+Y2AToZzHZWcgpYvGo/2BPRbVwM1/jXpqisItDokGxSFrBuNhLdxesKK0FF6Dkqh1q3cUQf0cumVcu7AJdjYTC7AVUReJjDdrbQQvLQX3ZrjWz5aFOr8oFdIOUpaDiuV/7VLNC4+8LduiCo38cCiuZuU+G3J5w9EU/HoNl4N9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31cwNY0U7Oo2zXlHykqWOFL7mkc6HFqgAcXUI78AbMw=;
 b=mFNZbCArvg8sOyXMR9Z14es40c2gD44m8uXOB5o3NheOkkpCJ4uH4yp961NgZpRik1R5nhri3wSeSPlFHbVW4hSGR++O+Z13+HKotdYklemUWujS1m9sXBjXRrC6KOI/sgtUq8iPeqjTwammRJeBWJ4ofjV9JrT1oDzm2mnZbLY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4732.namprd10.prod.outlook.com (2603:10b6:806:fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 6 Apr
 2024 16:37:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.042; Sat, 6 Apr 2024
 16:37:18 +0000
Date: Sat, 6 Apr 2024 12:37:15 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Subject: [GIT PULL] 2nd round of NFSD fixes for v6.9-rc
Message-ID: <ZhF6O/tcbLJYjddw@tissot.1015granger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CH2PR12CA0013.namprd12.prod.outlook.com
 (2603:10b6:610:57::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4732:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nBukw/COQViM2tgCMVkI5hHreDlrQWxMKPjj8J/AYkM3ibrcP4qjBM/NarqhoqB3izsxeDXR6oHsyXuZZskUet7Sm4PJjXm+LHOaJ38/JOugaf02hAtBoHzChJpb6VX+0kK66LrbNH3ropWvujBtD6Av1YfBwJ1k954Yac4kqRCWhQu74GmEozeAL5RDlHswdQgJqsCdaWW2LMRroouOHId+Izr1v1drE+S/m9knRbJ2VJ/ScKyCK60A50Sm5K4vtwUL5J991BMFYCxYQ20aw7s2DBVl9znYMrRCSF110/plYSZRAu6gv2uK42SyhzogfjUOJ+Vw07zttcQxE2VXPdQ9CkfmFsHZ/hfa0JUGtZFiQUvoW41wkiE5Holl1H4T3WFgO2TJntpzbGcwzCvwbGbufZw3tUfWC8fRhbsowzG4LAF8Zxxz3i/guOmVULpyDKYFlktG8AnFVid5Dd5KFir+B9jROKluTFdRbigPW+Azra240AGvCdonfTH9qm2B1zDIgklmo304MnfxorK7eJETJ+RhY4cq4B+iUDfmo21fL74kbnVNkQyfr0ns1YoGNRRDLZGoYBYi5gC3hrBwXYU+bEMXkgf2ZWAwZLaS/v0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hWQb2kIkbGRNlS8x4te7vghb5PWzHoguYQYYg7/xsPvemyvHak1tqyfy5Cty?=
 =?us-ascii?Q?4yZ9RCGnb8+GHf9LiSjdk+LhDWsykTJbWRNJLHvbiu9zhorcxM4KWxM95M58?=
 =?us-ascii?Q?glYvYqInRfQEaRGqZ9fz9Q8g3PRgKSTBMMzh4TmDZ1j76GpXQauGszhmUt3W?=
 =?us-ascii?Q?OdaakBFaHB5EIscnYOMoW7ab3WuazBXOYwUplQxwrVxeQQA6J6aTY2yxgOTK?=
 =?us-ascii?Q?tD+VWxEaVA/xO1PhJzDEBySSS7847gP3bJGHax3ievLs9onD8xUyqbRJSXtb?=
 =?us-ascii?Q?X8hXskJmK2POEOZ9jB/SQn2uu5ndrYkrmlBvLPY9auCslmOuvDH634tWM63g?=
 =?us-ascii?Q?mPgndFwk7JrrKWICWeCR4w0gTpe3SSOohd7lah8J13GBl/TslvD+/WLF8L94?=
 =?us-ascii?Q?h73g6dcOxExinEsfQI4iMMVcwrUo4hEhePSMZ13jDSbEuQMlSxul/7ZA+JYg?=
 =?us-ascii?Q?0S2Kwi8jKvw+5Q+g6zXCrrhKFNaXiWpZBmDkXxzSI9Yg9k2Jtsskgqlo/SuN?=
 =?us-ascii?Q?nXx42EcufpbelgAlaqKPkuNbwGPl1YRrKN+NUfTyuYcHXhlwrll5JQAj2C/8?=
 =?us-ascii?Q?MY9GdvPQNp1/4AdmoGPiJg2YmJ1lTGUX9+1hSRReUyU1nagBU6wBx1lg2Yn9?=
 =?us-ascii?Q?wNU1XM0FIC6YaEVVBSRFbu2oX8TJ8ddS2tfppy0ox0YW4+rkKXQf9szlMCD6?=
 =?us-ascii?Q?TDLxpCrPgteISHFBPUc7uDcxQQZjdN4sxGJzUuhJFdLXngjy9azKGNJAueUD?=
 =?us-ascii?Q?KxnyXw9TVxGbuGmZ3kahG5HIPbVEPpY6GEQ5lVFZkt6jWudlh9qcpHstYRSC?=
 =?us-ascii?Q?uQ9p2H0Bf9ES8fwkGYfpmwEUgC0KLOGrsVt6lpHj2rE5+P4BBFSZ0K5/uXr5?=
 =?us-ascii?Q?Z3IbE7tNT1rp8j1lL81DzsfM9SDZMVffJnegNM77ra39flL0PIQQJ5UcXqaQ?=
 =?us-ascii?Q?AfFicGxg2081JV79NVcUIrpWlNZut8OwRQIdBchJi7rKfP+JM0sz5CFF2mQI?=
 =?us-ascii?Q?FYwhy2t9FdlTy8XHX78lHGFWM7bFIbzUo1lDDdzSRhI0FNuvaTsuSn5WOwrK?=
 =?us-ascii?Q?Nt1lAyDmVA6Vt+g1fNOuE3ecNwOS6ASbNY7fLrwdIiANrMHdotMBFeS0TwBc?=
 =?us-ascii?Q?evHcN57a3xni4pNF4ppWVaDzr4/1crUc13YQdoOflPuisvg9tvKHhg2X4US5?=
 =?us-ascii?Q?LK0hZPiPpXAynq+haP4FvZvCxbZTk3Ikk9jYQHfSSDkLjdyujzE2e6lV87bY?=
 =?us-ascii?Q?qmVIyV2+gqREMpo8vE5jD4kmZThwQQCim9s5NTY8zGEhu9oC9DfHXksc8gri?=
 =?us-ascii?Q?nNQAFzd4YHL8QEBm78anuOX0XxlHbQn1PeV2IQgt1S/gIJ5la5jf5HnDoMOd?=
 =?us-ascii?Q?+I69CMf2zvd1s7C+Vek5lmJVHvw3rbPKxaRHOedHOW/WiGS5rQeqwfV1W7pQ?=
 =?us-ascii?Q?BKk7aCZ2shQfOn1nBmsCDITOZCHzcpxmDiShFL2TV9Qweuq4ZPjQbBrP7XDm?=
 =?us-ascii?Q?mzrrDUkpm1yzCXzcOAFLv0LAKoCxoWniQHugMnI8zOGZt+R75y9Ox7Lasz71?=
 =?us-ascii?Q?6BU5S/AKVfUURA8x0iTf9tVfwUZ1JMS47HlHaQ2WDVvBOYFo8/e6E7pNkKCG?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	52mO6U4mgD0bPPYomhCcqp2ZmzLjz6tCou7dlYqVR4lVsX185n8LpHADkpzlpKAL2biDYrZPOvnKaKPCx2cgElusxPoEFOC0Fq9PwE3XxLNzUWsShXUb++sBXmyv3hwkrRggUNtIC4+Eq8+12Rk/VGvxoiD38L64/2aG8mEjuj4L8g5K1dSPOQyK8LT9zJ6krZKDDMZPadLZ10kKLR1xRufzssket5rr/f80u+Yt0lhOP7l457u+w2B+k/0V4VJEv6Y6b2t+aC6fpFXzVV3RvkiveWOE897tF2dDRd6aUkRId53y07g7YkJ+tEwgyBwt7ErsCtImy/UAa4IxBOeQrMsEr/rgGCZx+ez6YFUJV1COpH2T0cbXtx0/zX69zARXI++j7zTRqDIY9fCJhh0HoEHZiSkhrq9NUc+JGISQIUViaJESGzt/JB23/K5OkbkK8RnBIxM0L++gJVNeC0f/3+r2++YL18dnY8B8Jh+VdR4Mrl0cktIeETbTWFSJOe1i9tWPhZXIyNxh0h28bRexjhdpKcmQN7QuV13pzN1T8jtY7QJS40cnGS7kMp5OnrAaB1QUUMJbxanE46yJEmIOxCFYbqec/i48Vv2jTpZdSo4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d95ca42-7b6a-46ae-8ade-08dc5657d2c2
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2024 16:37:17.9070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8KQjLEkPSAOdhR+rDhOy2G+xrvuwuL3TXBzpIpwsPgbd6SG6lOuifh8sDGjhl8co2LZvkkpOvl5NjQKsTvpGig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4732
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-06_13,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=740 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404060131
X-Proofpoint-GUID: l3fU6_YEZmYTLINTgk0Knocx8QAjIKBO
X-Proofpoint-ORIG-GUID: l3fU6_YEZmYTLINTgk0Knocx8QAjIKBO

The following changes since commit 99dc2ef0397d082b63404c01cf841cf80f1418dc:

  NFSD: CREATE_SESSION must never cache NFS4ERR_DELAY replies (2024-03-27 13:19:47 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git tags/nfsd-6.9-2

for you to fetch changes up to 10396f4df8b75ff6ab0aa2cd74296565466f2c8d:

  nfsd: hold a lighter-weight client reference over CB_RECALL_ANY (2024-04-05 14:05:35 -0400)

----------------------------------------------------------------
nfsd-6.9 fixes:
- Address a slow memory leak with RPC-over-TCP
- Prevent another NFS4ERR_DELAY loop during CREATE_SESSION

----------------------------------------------------------------
Chuck Lever (1):
      SUNRPC: Fix a slow server-side memory leak with RPC-over-TCP

Jeff Layton (1):
      nfsd: hold a lighter-weight client reference over CB_RECALL_ANY

 fs/nfsd/nfs4state.c  |  7 ++-----
 net/sunrpc/svcsock.c | 10 +---------
 2 files changed, 3 insertions(+), 14 deletions(-)

-- 
Chuck Lever

