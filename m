Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F99B79D1F9
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 15:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbjILNVG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Sep 2023 09:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjILNVF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Sep 2023 09:21:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC76010D1
        for <linux-nfs@vger.kernel.org>; Tue, 12 Sep 2023 06:21:01 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C9nKs2028552;
        Tue, 12 Sep 2023 13:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=7KUi09XNETXa6EbBZHUtlMu+0k99MkWaE5fYY6XwO7c=;
 b=QM5B2n4PtYfzPuTHIIrVrGanmWfn4Tj+PcprOFQKWA9TaGyeVOCiwNJ2PeXN1PChUdI+
 6+P983ygCylSuc/mQCAgLvF//1p5qyzyqecRjWTfsc8sc6yvmKFim1MtG0Ut/y/ku3NA
 wnNHnz5KVmjC+UvSfHmAeANXDeLJrvWntok1q5gJmZQOziwVE5p+HEDGKf7ZB72Z5tpr
 7FvKjvYLfhKuMp/Dx7iT2M9aFb93ZQrgai8OIS0Jpg2ltsKBdF0th0DmUmZeKJoaT6qx
 jIL3Vt9KHmD6cbjZsyPUxIJsevcXSbzfcsJlYTtnbrkP0TEF+ApqFcatRTAe1MkYLhuK uQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t1jp7bx7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 13:20:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38CD8eIo023099;
        Tue, 12 Sep 2023 13:20:51 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f55ywgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 13:20:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4KgdPABq9WRpO0CHy4GU4/Fvy1YQ0VFmSKTG1fd+8MY/XfSzEX/HzxSE7K4gQoXAa1V3SgWSITduyGFmnQd7vVfp+AEg0/Vsj4Dfqs9JqVoctKqiSzWwAZGBGjsnSFblqOSv1lHDxCDiUzzD8hF6+hpi7YwglsWLkZ6zdkneDluzICs4O/DHB+n3D7WTxQHKm9NXYxt5cRHYw99XRkTeVknD8ooekciVtBNKiR9vBUgKCZyVrEddRaoDguA1nZNyUmftCLzv62xblkPcrgeAt4el4ElWLsq0qwxJvENQW+ButvSTitJfJBkYOHlsCOrJknJVr+j91vxJj4ngHHa0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KUi09XNETXa6EbBZHUtlMu+0k99MkWaE5fYY6XwO7c=;
 b=axNb4BwJv7P0yOa7sI8sPT2fFu6AakLg0fVv773OVocYLtadrTFU4jN6Jy8cd6tJUjYzwE+kmVtfo10gCCNme89XhBIijubd0VJG+OT42jg4OnYz1JwoY+lTwLoTWHNpp9DUY2DW3Yf9P2VflWGV4Mdv4+6k9XkDKm7FI+uQfxCuQHwGb3lK0swu57vZuiQj3lzFvxspWf/svOuU/ytf3NonRR+bKlYPWqArws3Ay5fW57FZ9GnpKWbdE8tiJEDtRO8nHol56fZiqQERr/Un/+WUa7zIVhocYHEduMZ5LWpMeNldfg4pwgA5S4CTTlG9yAeKj8Ix5Qhv4/sXU8AMsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KUi09XNETXa6EbBZHUtlMu+0k99MkWaE5fYY6XwO7c=;
 b=eWvtqmH8MP42CAO4rWJSqf0fezZ7SlVSNnK99RAunMTITP4rrltJOR5iiQEoe0bF6pzcpMB8iEfQXm1YyCBJPRvCAJLfSouIzLg1+MXCCYec66uFqlyryn1mvmRjRBLQFdchywtXiTeBYUkKmOOow0/VP+TQ/unh7ky8sTmAW5E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB4800.namprd10.prod.outlook.com (2603:10b6:a03:2da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 13:20:49 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 13:20:47 +0000
Date:   Tue, 12 Sep 2023 09:20:44 -0400
From:   Chuck Lever <chuck.lever@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: Re: [PATCH] NFSD: fix possible oops when nfsd/pool_stats is closed.
Message-ID: <ZQBlrGOvF42q1ZWh@tissot.1015granger.net>
References: <169448190063.19905.9707641304438290692@noble.neil.brown.name>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169448190063.19905.9707641304438290692@noble.neil.brown.name>
X-ClientProxiedBy: CH0P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SJ0PR10MB4800:EE_
X-MS-Office365-Filtering-Correlation-Id: dbd6a40c-ea21-4f78-dc07-08dbb3931392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aax7OzReMHx7gdgYSOJJHCyG5qk7La2C3nCxVNzs9pFvvVibo4XCsTzd4olu/k+PCrs2vCLCahZIUAUDdBBSvDk3KVTyrndgttS+NX/3WduQZ9mOI+eRjXdbZG95EZyhr3T2g+uYot0jJz9SL9s5LdrdsZwED1Oq0QW+s5OfLdj++PYiWyRf8U/G0wESAsu3YlxZmLqxlU135a8pGhMC8uAKOQzbIWPOms9Hrw+CgZqa5sCyFofaBEMdl6xvhIbcMOr9IWRjo5RZqk/7b2UQxVWCdC7vnZWvqvwfgWE8Z4+WvyO8ALKKIgMtg5HyaZVSk0RHydPpD60vOo6VQtvFD9cBJBMIWGoRFgxa0lnqzHDK1wpfGMPfk+L7lx4TEcfr/akVU9MOdcbWpDNRhkr/cVHo/XIicrEvRioYcHTBXs2UmgkLKMVgtEOkOdEsuoAYEqAafboOJy1vaapTxjYA+dirQRTJYcxq0sbsz+RTphEa3m2QhKFalvLs6E2MA4xnsQR+fkMlQRRken9GrqXpaL31oc8DsidxGjhRke0zeE8MJBec1ud57UuW/Jqwtpc1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(136003)(346002)(366004)(186009)(451199024)(1800799009)(41300700001)(316002)(6916009)(26005)(54906003)(44832011)(8676002)(4326008)(66946007)(66556008)(2906002)(66476007)(8936002)(478600001)(5660300002)(6666004)(6486002)(6506007)(6512007)(9686003)(38100700002)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CBjLAEOigEW77vTkSFJ4rf6HyA6/MOJZ0fZEfp8rvknsgKjQas8icab+NBB8?=
 =?us-ascii?Q?6Io2cPFAvJ5YQ1sXyh3DIk6BZzA/IPnchE7/AZv+4KqaTvGn5H0oui3QMlOS?=
 =?us-ascii?Q?+cXsCGvuwbiXrYSyCXmVLyqmtSeKCbxKyxz5HboGXFGcQ2Yb8Xw9VvcsjxgL?=
 =?us-ascii?Q?vNWy6DAJNx7nJLm/KCFwkfmvqZrn2g4PxufEMJyMEoJCGbim1YopcVCpvgYM?=
 =?us-ascii?Q?H8LjjLzHpjB2wqj25Ox2odGpdpIJIA3AxnJzp2c0Dh1ISnr1/rZ0nFHtens3?=
 =?us-ascii?Q?G0a8z0Gp4lliEjBnhqy8749uDkrBd4f2Q5EBlLV/WnawmaHSdHXzkvLx24iU?=
 =?us-ascii?Q?rqtgwpWttcz4CpU5u7Wu906/1NLgmUAdhQuWKSYSlalno4D+Km1M4/VHVOq5?=
 =?us-ascii?Q?5dmFh5clcHdxNGIgsOT7rxbmZmA+SwxaG7Cyxh78bnl0rW/4z+Tcv/cTm/Nn?=
 =?us-ascii?Q?qfuOnTVnfzL1qbrV+brOV7xPYieavynAqjpqd4vACfFXJe0SCC7hCWT65OkI?=
 =?us-ascii?Q?JyXDEDSE71HBg5ejzqMAAKA/JiFw3BzCZGhvnsrvi/rz6P2wo1I3hdDO+/na?=
 =?us-ascii?Q?CPjKdsoUifaWW+maU8xb+W7GwOludtJqWiix8XKqf+NyMTf8xucRumDUl+fN?=
 =?us-ascii?Q?TLzheT2A8m0NLswzsRQ3Z73eUqkttxCfd+oT0Z8CISF6t3zk1Y0mNfrSKLMC?=
 =?us-ascii?Q?4hDpTM1wUedID+SBzPe1H8iRD9N8nDnAeX9FTX5y+dIKBw36UMHnPGkgxVKk?=
 =?us-ascii?Q?Y00rqA55DWsr+Y+Dpwca3eel9wVdK8fTBoFRrK8tvJ/1GtOzddbIi4RvVYR/?=
 =?us-ascii?Q?G5xeRARm8AG0PaZDFN8n/i5CBzKbOpztYqjWhWqdB5DqlNmVJZvBTc3UdrY7?=
 =?us-ascii?Q?DZhxtLfKSPm0XbL5Ec4o4RCGjJdv//Ai2YtGL63m4Vhq6iRKCFriP7vyb2T5?=
 =?us-ascii?Q?kpHO/xHNtJUnPbCXWJeFVRSggsmkDXK7hUDQX6JRFHqd+sGeZjVWB/U7pKwQ?=
 =?us-ascii?Q?lTehGLqjr9Vf0AoJMfKGUWVvH+qYhEYfna2NtSMZcUos3BvZJ2AonpvrDhKL?=
 =?us-ascii?Q?ELIqYaoLuhButRi5JpHmhPGd7W6sE4hXEmFHqfLhsWcGhgr+oZPNN4e/VxNg?=
 =?us-ascii?Q?urqw9IIdYkI8yebjWZ/ag/N4Aj+/QijI6m6XNvk48M+DUNnLTqQtNi7glvYq?=
 =?us-ascii?Q?4Ce24ZspyFbHfJeaZMB+GgsaBzfSm0mUl54zabmCOEp2SnNtJvC+aR6giOR5?=
 =?us-ascii?Q?fFRHm2vB0qA0XSHDBA7B2ehohGeOuAmnDMwzcgNeAiCZbE5YmFu3LVUuLJcn?=
 =?us-ascii?Q?lpXqjyHaPRROkTYsSMGFuhgt8iD6IgpmJN208UWgcFzmwajvPS9AO1MObl2O?=
 =?us-ascii?Q?47GSeg/IR1NFO1UjFMht85Aub9oEjdtZGrW35ieZaYSk3bUDNx0JT8iwYYrD?=
 =?us-ascii?Q?QZfS+wJSkgvLoSEVic8dfzvByXiyGVIAjeZJS2NVUSF7q4xyXFDPFz6IguHA?=
 =?us-ascii?Q?wL2sYNg8Z5dbCuLICd5N/ERRilOYxel5auRmbcmlsC9YukEd3yBsuJ83dLS9?=
 =?us-ascii?Q?XUiSdnOAep6eJlV1W8qpAWG5/8NyzsAhfdWK0HkVW18JObbg7JUXqENvd9Nl?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wMRwG0CX9nh9nQ4KwchgsSaMXvOhrW3GoVppcnFLMaPJMyyri2ZNnkEgbbg2AxDc2or4h/3ufBlBa1qC5BFEr3Uk2OSp7IQwdKJ8dlzkhvlPcFSUgKzTf6i6yejLsVV6BbApuq429M6PC1ALP7WYe21amaHZ1DxrbpgWsFH5n2f/3RO5urCMIUAlH4gnlWhk0RYFP7jqkSMPT6UYKTK7fvbXE0Y7erwR8lGIoQGgcaDo2482SgW6eDoLvPxQcyG9fX0Q7XvhIPUlmdlmnSR2yaXBD4xNLMOXW5rl50Dh5VUd3n5ozbUOOLnidJFiJ8AuVHaQTKt7u/2pv+n453S7U99yGyHbwcLD8iSlMyiykYFzYTVrsL5vZuesNvT68Ij5igntE8BZ1Ns4H+4jOU8dM6cxbNLCtMGahyflo2RUNK02zSqyvOCw07iN2xEz7ThEcZL7NWMJThtl7iBDxQYrQkrmDqKEfXL4IsMkE+8BxTfU/9WfEB0HFsiL2RBgekvs882QsGr0PssElZHYr9AqKTuEvqyYKJzX0CNHD6wkD9PYH9W22vMxBPoNdxJY+1fznadt8wib2qwcCC9udALFLouFYUYiPZcZh2M8ZUZzXgRQRxQ2OQDK3pj/tCxx0Xn+YrcJqD2D2yDVuexUwwICEAOTMcoh14O+bs23+zGdJ/ftA7nxCx7zTbymUkOTfWr875P1ddC0tu4II5amw020Rzqrz/7GQe/yAYdn8kY9Zz5gFAy1UgkqW+57q3sNRC9+f5pv2TnMBWLIZhNdurBhoKgKQfIcUDXm9D5gVbbu87dQauJRj6ntBM8QUiomkpYm+apHZ5mJGFSDnObJOgkRzlJjQ4jBzZlowUp+eYXVy3YC2CSkdgaA4ffA5TdbfYgd
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbd6a40c-ea21-4f78-dc07-08dbb3931392
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 13:20:47.3822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVCC+Z+iEAw5HGaC52SnO+fgHlYR5TdoGBqGtCPts2uqj9dqnTIoFApn2teRTyxUF0Y1Ox3u2tXtnsKbmuvBqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4800
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_11,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=935 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120110
X-Proofpoint-GUID: M-U7HCjpElweD0W8EK5inYnlaea-x-0Q
X-Proofpoint-ORIG-GUID: M-U7HCjpElweD0W8EK5inYnlaea-x-0Q
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Sep 12, 2023 at 11:25:00AM +1000, NeilBrown wrote:
> 
> If /proc/fs/nfsd/pool_stats is open when the last nfsd thread exits, then
> when the file is closed a NULL pointer is dereferenced.
> This is because nfsd_pool_stats_release() assumes that the
> pointer to the svc_serv cannot become NULL while a reference is held.
> 
> This used to be the case but a recent patch split nfsd_last_thread() out
> from nfsd_put(), and clearing the pointer is done in nfsd_last_thread().
> 
> This is easily reproduced by running
>    rpc.nfsd 8 ; ( rpc.nfsd 0;true) < /proc/fs/nfsd/pool_stats
> 
> Fortunately nfsd_pool_stats_release() has easy access to the svc_serv
> pointer, and so can call svc_put() on it directly.
> 
> Fixes: 9f28a971ee9f ("nfsd: separate nfsd_last_thread() from nfsd_put()")
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfssvc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Thanks, applied to nfsd-fixes (for v6.6-rc).


> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 1582af33e204..551c16a72012 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -1082,11 +1082,12 @@ int nfsd_pool_stats_open(struct inode *inode, struct file *file)
>  
>  int nfsd_pool_stats_release(struct inode *inode, struct file *file)
>  {
> +	struct svc_serv *serv =
> +		((struct seq_file *) file->private_data)->private;
>  	int ret = seq_release(inode, file);
> -	struct net *net = inode->i_sb->s_fs_info;
>  
>  	mutex_lock(&nfsd_mutex);
> -	nfsd_put(net);
> +	svc_put(serv);
>  	mutex_unlock(&nfsd_mutex);
>  	return ret;
>  }
> -- 
> 2.42.0
> 

-- 
Chuck Lever
