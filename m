Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335C14343FB
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Oct 2021 05:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhJTDtp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Oct 2021 23:49:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55008 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229635AbhJTDto (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Oct 2021 23:49:44 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19K2H8F8022170;
        Wed, 20 Oct 2021 03:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=+xJx0gBYlurxvxqg0D0ATtu7lnmOAfWKUZm2vPtGIxQ=;
 b=unP/9rj0PujjimTqRE9QR+LHXmIPt1gji7+PEcpoMA5uZont9BsIeRHWOyJr0IreG7yG
 NcVK2VBVxqF3FKsrXd1DT0qNHeGxWH0IANqQJQ57Otg/UKUY8ztTvGQGB+Nurd6lfEbg
 8litaBbDyfmZCQg7d6Yr6Q2bEf7KiQEkPWtfIP9jkAOpN6vHOv7Cd8LOnZ+0Hqhaa7uH
 BRVYPeLmohSik6O82z9bT2H08QPPJ3EZWoijwtpx/4nLpsI94wRANzKAOErJOFbaag99
 bPdUyyyS9fC53Pdkf/TjcGzo9EHXAUWnkHLkgXMG9w1qqIUoT33q+Bs2jXdf41FEIrhZ 6A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bsrefehgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 03:47:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19K3fXX5183013;
        Wed, 20 Oct 2021 03:47:26 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by userp3030.oracle.com with ESMTP id 3bqkuybyh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 03:47:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ji4aE0q6QFLAYdA/0fdAGYMlO1Y3QBDkVTsBkXYx46ceE8+4H++eb03XFq1X7SokJjzU7sUrhGWw0FGdgci1N9nB/Ddks/fVjO7JBXWTxeCN9SDQ3Oh8XTYSKw4G/igo+Zid/GfgGWr3iOue5W3c+DdcqG4aziqffQlqTFwpqF69YNLlJTd3hUtNM37JZiWb9n1EzzU0d3Wn6OfiU2plXbSjE+c1fUaKcrmuNybmhqqoCK5GQb5+TArVE4FFz6A8pOoK2AeaP09+LNqQJ9mFgiDdbn8xhe9TM1XCiESe1uepQ4ruSH1DnwIRjTWne600LLbNf/fNZ6hbnvUmpS+IxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xJx0gBYlurxvxqg0D0ATtu7lnmOAfWKUZm2vPtGIxQ=;
 b=PvrQkqJsQXzW/JRbl2KGSqc4AmU3pOMkEd7NI0+XYbRinanANSKjkqMWRXD0yElD9NGhItwW1zc3VlFSkgU7cifOts6I+Si4oVrnS22qXjr20VUk6qvVIEX8Uk+hpGvVD6D7kMYQDuvZqn/4enAZSUjO5F8Sc8nIufNSHd+NbQvTdLnQ7IEkBnbrwIuisadfdBS/Y0Y3Vqrfuuyh1OLeQgIRKryECj3Qp4S7/LdBwljagrzaaJKhNdjCRMfnwOCtpshaQRbnXCBCvBAANWBQRwxrdiCFLF4Ol19v6hc3fFAdnOmrUYHwAHdASBhHmVqz5syv7zTQYrefRvhuLrFEww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xJx0gBYlurxvxqg0D0ATtu7lnmOAfWKUZm2vPtGIxQ=;
 b=pRsNLdRIxHo6koZ9AEsGXIMdCmJW5EOEkjcQF4kHdXVT8Z9bvR3M7ytWhoHCh63fc3qPOY3oQauuSBdwaQY/km94xwWBviWuwJnWxAM9GGqBT5zzFhWIXo15cLn3Ss5B24Vo3fGKcl6pgYsusFkWf2jBcUcG1iJOBuA9VFlXRkA=
Authentication-Results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4678.namprd10.prod.outlook.com (2603:10b6:510:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Wed, 20 Oct
 2021 03:47:24 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349%9]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 03:47:24 +0000
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/7] block: add a ->get_unique_id method
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1bl3kbboj.fsf@ca-mkp.ca.oracle.com>
References: <20211019075418.2332481-1-hch@lst.de>
        <20211019075418.2332481-2-hch@lst.de>
Date:   Tue, 19 Oct 2021 23:47:21 -0400
In-Reply-To: <20211019075418.2332481-2-hch@lst.de> (Christoph Hellwig's
        message of "Tue, 19 Oct 2021 09:54:12 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0005.namprd10.prod.outlook.com
 (2603:10b6:806:a7::10) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.201.25) by SA9PR10CA0005.namprd10.prod.outlook.com (2603:10b6:806:a7::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 20 Oct 2021 03:47:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d07c0e6b-dbbc-4c8f-94dc-08d9937c53c1
X-MS-TrafficTypeDiagnostic: PH0PR10MB4678:
X-Microsoft-Antispam-PRVS: <PH0PR10MB4678EAA11F866975C30AFA068EBE9@PH0PR10MB4678.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2GvkRuCGahPHUKjyNBQj2q4ocCFvRBR5RhKOpHIHhpbiFO99faP2y/CISrLpD1g3kM35vh+pVfQZ3BOZnQqUR5BQZGIXn2n7K1ppT8NNk+jeDPA8dx5ey+H+rzDwBHwQxSpl63kJoJFFNVHoeRSl4grmA7BEoNIP5tg6yKbmnCHiR619DHd8ycpMBAB8AUALw184aY+hbbHzmbQWIN28siny2YhnSccqK7No0cYjxR/GQcoFUrCuirOh27JDKuL531GmkpZEaEeyRSW3Ga/5aJIt1eESqwb4h90oC0K1g0BP4HFuNBiSDaOsR10MM3Un98S7dEGPxE4cAjNsXUnO1j0E4GJRGqmMTvPg8DiEXzh6sbG47hcXKtBS/sGJRz1WqzmYg8xF5uAMvxoedcL6ueORkYvCwRePmKopB2ewFj64yS0NWWZ7u2BbKO/asO+d+hDb59PoSn+nLNDwoCW8LXtbsFwpMaWcl7oxKZyrupdYuV04r3rw7Z9kGgob8Zz2lReEY+jzdlPJXudxGSm2V82iEcU1LHkwnkmfQ2yOScKFgatuV32e+U2kIncrHsCN+1QdMjQf+Jqq9qTmRVo3lBXKjcqb3E+2yKlSdqIW7dVIjwf7jyLaxv9XWaxKIpHyQ1M3Anz27Om7aVY9bizyIOhQs8SHrMzMpeI6K5vaE5DC3R03ajOjOY1hgLAE/WQUMks2kxjhUjlKopN/IZz8Rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(5660300002)(8936002)(54906003)(38100700002)(38350700002)(8676002)(6916009)(83380400001)(2906002)(86362001)(26005)(36916002)(956004)(186003)(55016002)(4326008)(4744005)(52116002)(7696005)(66946007)(508600001)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YeNMDgmgrULIk+UkJlsun1axsOMfsuBeM5g0PvitfWbD/S1ZkhPeYL7Pqghi?=
 =?us-ascii?Q?ZvbJ9zLhPgC8P2bVgg3b1TAV0vb1YOfyeAHHdAAfsU0CUdaX3xxC++nKOWBZ?=
 =?us-ascii?Q?S5wLaBKwh9QgrX2NXxhfxx3z+QNlngIgggQn09vBOhkrMm521bFDL2Gy1QtJ?=
 =?us-ascii?Q?VJBiTR2rb1IL4nRJOrkrggrDh1Yg0YLaq9T7CWSXauERQ+6KeR3u/+3EW4RW?=
 =?us-ascii?Q?0Vb8l5oo4Izlk2M1ZE00lduzihES4LPTwSOvZGIXOtGhvBSL/ouIf+A8IHZW?=
 =?us-ascii?Q?/8/Me246rGBXrsWCYluBioHCM8+NbLr05iGdVDBOA7qWlmVYKN+5yvPLCXU4?=
 =?us-ascii?Q?l/+gxWk10cu8agHh2OOrG4hip/HOLdfV3bC0nBnvUxWXJWPf/fVku2xcT68b?=
 =?us-ascii?Q?YVdZrife8eno26lwtjL06VfTByo7ZUNHTK2Qu1WokQBB7Ksx3Pekk6AetLvS?=
 =?us-ascii?Q?lDRJy0/Nj3RY5jWGZKX2OWaE+PJTPlXMvwA7mH/gXjiJ1qdqatt70Pa0jJYc?=
 =?us-ascii?Q?R8AM9Q7P0my28cpUMWNOKGl1k+9wQYgKhKXZwyjd+ktm9qB1Ps5AW6Yn8CsK?=
 =?us-ascii?Q?e86bt1LhVw6Y+A+ptmU++GRyzONqfXN/C9oFpfzmhCeuFE6XgDKDw8eoD/z4?=
 =?us-ascii?Q?WhbpJPB14Q/lNBEMNtv1hfgIgoj4glodY0l1yeA6pQLn4IqLRLuWyfdnfZJo?=
 =?us-ascii?Q?jxg+FvN4Op4kmzCved9gRI9q0NFeMvuyUJH+TCp6Iko5GPNSI4PIyNPWjlak?=
 =?us-ascii?Q?+z8BdskRGtS5tCihwrNp0qRw4hLewAtZo+x8Mq1Y2FCkk1PTwRvdJHHI/GJE?=
 =?us-ascii?Q?mZNiQha+itjqdA/b1C9+myYrgmOfVmAfCLnMLjdXdRZP+S7HYcNPsZZlEEWN?=
 =?us-ascii?Q?lAF+JT60kGIO4cTEc2ITvtk/x/c48ryRipHWp1NgrnB2HKOCnAp7fNSObI4I?=
 =?us-ascii?Q?2/FDkFiS7j/UXQqwMlPzmt05ECCk0mmLftYlndRoBIEiDSjSMoH1nKNmLOGw?=
 =?us-ascii?Q?wcHIVdkR54euwq3BIT/BqeJY2kAxFKoxeJ+38375VODtym9/ITBFvVMnE8nz?=
 =?us-ascii?Q?fOQfXIIsef7UXD58f0+62RqLKyNWWaAASk2U8Bh8EKnxZV87yuZ5QmJ6kGdo?=
 =?us-ascii?Q?R+NtU38ssmLv/JyhKVP0cYV2CsQvBeorhRPWDUK3koFJ0ukhctVFoRY+iJIr?=
 =?us-ascii?Q?L9CiTHalQ45eJqyHp6Tc4HkS/ycULW+LrDztfgvTkBMlBkbZHra/wv4utClK?=
 =?us-ascii?Q?C5vKiAzp7ZM5KWfzUEnsVrp7xnrUgOr9hsLQZsOAnpoBVOLc7y9T7CNeJ/G1?=
 =?us-ascii?Q?6+jIeOlrH75elUZvFpw8Qa/o6779foPLfOhZyIIkGl/Mw6e/qWVXPxJ5nPJ6?=
 =?us-ascii?Q?NHX2MUz0nGPCIWHVIvIRSC/nztre8hyMPHOcQKVEWjIK/29lNq8oKz1AU0Tz?=
 =?us-ascii?Q?dT0Hlfz412zzxCWoN7+qsNMQ9avReP0H?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07c0e6b-dbbc-4c8f-94dc-08d9937c53c1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 03:47:24.1323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: martin.petersen@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4678
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10142 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200016
X-Proofpoint-GUID: LFcg8valKD7hlfju7toUwNF5DTojr6Ap
X-Proofpoint-ORIG-GUID: LFcg8valKD7hlfju7toUwNF5DTojr6Ap
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Christoph,

> +enum blk_uniqueue_id {

uniqueue as opposed to unique?

> +	/* these match the Designator Types specified in SPC */
> +	BLK_UID_T10	= 1,
> +	BLK_UID_EUI64	= 2,
> +	BLK_UID_NAA	= 3,
> +};
> +
> +#define NFL4_UFLG_MASK			0x0000003F
>  
>  struct block_device_operations {
>  	void (*submit_bio)(struct bio *bio);
> @@ -1195,6 +1203,9 @@ struct block_device_operations {
>  	int (*report_zones)(struct gendisk *, sector_t sector,
>  			unsigned int nr_zones, report_zones_cb cb, void *data);
>  	char *(*devnode)(struct gendisk *disk, umode_t *mode);
> +	/* returns the length of the identifier or a negative errno: */
> +	int (*get_unique_id)(struct gendisk *disk, u8 id[16],
> +			enum blk_uniqueue_id id_type);
>  	struct module *owner;
>  	const struct pr_ops *pr_ops;

-- 
Martin K. Petersen	Oracle Linux Engineering
